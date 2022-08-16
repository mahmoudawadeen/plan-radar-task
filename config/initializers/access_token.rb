Rails.configuration.after_initialize do
  begin
    Rails.logger.info("Api Access Token: #{Api::AccessToken.first_or_create.token}")
  rescue ActiveRecord::StatementInvalid => exception
    Rails.logger.error('Restart application to generate an access token after running the migrations')
  end
end
