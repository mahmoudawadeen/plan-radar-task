class CreateApiNotificationRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :api_notification_registrations do |t|
      t.string :name
      t.string :mail
      t.string :mobile
      t.string :notification_method
      t.string :notification_frequency
      t.string :city

      t.timestamps
    end
  end
end
