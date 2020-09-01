class ValidationController < ApplicationController

  # GET /
  def new
    @validation = Validation.new
  end

  # POST /validate
  def validate
    @validation = Validation.new(validation_params)

    # Trigger validations
    @validation.valid?
  end

  private

    # Only allow a list of trusted parameters through.
    def validation_params
      params.require(:validation).permit(:metadata, :validator_id)
    end

end
