class Api::V1::NotificationRegistrationsController < ApplicationController
  before_action :set_api_v1_notification_registration, only: %i[ destroy ]

  # POST /api/v1/news/:city/register
  def upsert
    @api_v1_notification_registration = NotificationRegistrationService.call(api_v1_notification_registration_params)

    if @api_v1_notification_registration.save
      render json: { deregistration_url:  deregistration_url}, status: :created
    else
      render json: @api_v1_notification_registration.errors, status: :unprocessable_entity
    end
  end

  # DELETE, GET /api/v1/news/:city/deregister/:id
  def destroy
    @api_v1_notification_registration.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_notification_registration
    @api_v1_notification_registration = Api::NotificationRegistration.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_notification_registration_params
    params.permit(:name, :mail, :mobile, :notification_method, :notification_frequency, :city)
  end

  def deregistration_url
    api_v1_deregistration_url(city: @api_v1_notification_registration.city, id: @api_v1_notification_registration.id)
  end
end
