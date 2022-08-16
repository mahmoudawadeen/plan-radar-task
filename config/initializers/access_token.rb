Rails.configuration.after_initialize do
  begin
    puts "Api Access Token: #{Api::AccessToken.first_or_create.token}"
  rescue ActiveRecord::StatementInvalid => exception
    puts "Restart application to generate an access token after running the migrations"
  end
end
