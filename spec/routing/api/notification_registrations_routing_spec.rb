require "rails_helper"

RSpec.describe Api::V1::NotificationRegistrationsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/api/v1/news/vienna/register").to route_to("api/v1/notification_registrations#upsert", city: 'vienna')
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/news/vienna/register").to route_to("api/v1/notification_registrations#upsert", city: 'vienna')
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/news/vienna/deregister/1").to route_to("api/v1/notification_registrations#destroy", id: '1', city: 'vienna')
    end
  end
end
