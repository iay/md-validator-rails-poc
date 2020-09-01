require 'md-validator-client'

class Validation
  include ActiveModel::Model

  # The metadata we are validating
  attr_accessor :metadata

  # ID of the validator to use
  attr_accessor :validator_id

  # Collection of results of the validation
  attr_reader :results

  # Local validation is performed first
  validates :metadata, :validator_id, presence: true

  # Remote validation
  validate :send_to_validator

  def validators
    # Only contact the back end for this once per instance
    return @validators if @validators

    api = ValidatorClient::ValidationApi.new
    begin
      @validators = []
      vals = api.get_validators
      vals.each do |val|
        @validators.append [val.description, val.validator_id]
      end
    rescue
      errors.add :base, "Could not get validator list from back end"
    end
    return @validators
  end

  def send_to_validator
    #
    # If we already have local validation errors, don't
    # bother contacting the back end
    #
    return if errors.count != 0

    begin
      api = ValidatorClient::ValidationApi.new
      @results = api.validate(@validator_id, @metadata)
    rescue ValidatorClient::ApiError => e

      begin
        body_vars = JSON.parse e.response_body
      rescue
        body_vars = {}
      end

      if e.code == 400      # bad request
        m = "#{body_vars['error']}: #{body_vars['message']}"
        if body_vars['cause']
          m <<= " (#{body_vars['cause']})"
        end
        errors.add :base, m
      else
        errors.add :base, e
      end
    end

  end

end
