class WeatherService < ApplicationService
  BASE_URL = 'https://api.openweathermap.org/data/2.5'
  WEATHER_PATH = "weather?q=%{query}&appid=#{ENV.fetch('WEATHER_API_KEY', 'WEATHER_API_KEY NOT FOUND')}"

  def call
    Rails.cache.fetch("weather:#{@query}", expires_in: ENV.fetch("WEATHER_API_CACHE_MINUTES", 30).to_i.minutes) do
      weather_path_with_city = WEATHER_PATH % { query: @query }
      weather = JSON.parse(Net::HTTP.get(URI.parse("#{BASE_URL}/#{weather_path_with_city}")))
                    .fetch('weather', nil)
      if weather.nil?
        raise ActionController::BadRequest.new('Invalid Query')
      end

      weather
    end
  end
end
