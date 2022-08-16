class WeatherService < ApplicationService
  BASE_URL = 'https://api.openweathermap.org/data/2.5'
  WEATHER_PATH = "weather?q=%{query}&appid=#{ENV.fetch('WEATHER_API_KEY')}"

  def call
    weather_path_with_city = WEATHER_PATH % { query: @query }
    weather = JSON.parse(Net::HTTP.get(URI.parse("#{BASE_URL}/#{weather_path_with_city}")))
                  .fetch('weather', nil)
    if weather.nil?
      raise ActionController::BadRequest.new('Invalid Query')
    end

    weather
  end
end
