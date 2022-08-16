Rails.configuration.after_initialize do
  begin
    token = Rails.cache.fetch('access_token') do
      Api::AccessToken.first_or_create.token
    end
    Rails.logger.info("Api Access Token: #{token}")
  rescue ActiveRecord::ActiveRecordError
    Rails.logger.error("Restart application to generate an access token after running the migrations")
  end
end
