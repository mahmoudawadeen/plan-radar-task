class Api::NewsController < ApplicationController

  def get_by_city
    render json: [
      city: city,
      latest_news: HeadlinesService.call(city),
      weather: WeatherService.call(city)
    ]
  end

  private

  def city
    params[:city]
  end
end
