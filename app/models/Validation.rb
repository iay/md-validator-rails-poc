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

  def get_api_exception_message(e)
    pp 'exception to message: '
    pp e.response_body

    #
    # Start by assuming that we got something explicit back from the
    # web service. This will be a JSON object we can dig deeper into.
    #
    if e.response_body
      begin
        body = JSON.parse e.response_body
        m = "#{body['error']}: #{body['message']}"
        if body['cause']
          m <<= " (#{body['cause']})"
        end
        return m
      rescue
        # fall through
      end
    end

    #
    # Nothing came back from the service, it's a local issue
    # of some kind. If we have a message, let's use that.
    #
    if e.message
      return e.message
    end

    #
    # No idea.
    #
    return "unknown validator API error (#{e.code})"
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
      errors.add :base, get_api_exception_message(e)
    end

  end

end
