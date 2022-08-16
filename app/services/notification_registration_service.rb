class NotificationRegistrationService < ApplicationService
  VALID_NOTIFICATION_METHODS = %w[mail mobile]

  def call
    case @query[:notification_method].downcase
    when *VALID_NOTIFICATION_METHODS
      unique_params = unique_params_for(@query[:notification_method])
      check_required_param(@query[:notification_method])
    else
      # Save the info even if the notification method is invalid
      Rails.logger.warn("Saving notification registration for invalid notification method #{@query[:notification_method].downcase}")

      unique_params = @query
    end

    notification_registration = Api::NotificationRegistration.find_or_initialize_by(unique_params)
    notification_registration.assign_attributes(@query)
    notification_registration
  end

  def check_required_param(param_key)
    if @query[param_key].blank?
      raise ActionController::BadRequest.new("#{param_key} can't be blank")
    end
  end

  def unique_params_for(param_key)
    @query.slice(param_key, :city, :notification_method)
  end
end
