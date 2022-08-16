require 'rails_helper'

describe WeatherService, type: :helper do
  let(:weather_api_key) { 'WEATHER_API_KEY NOT FOUND' }
  let(:city) { 'vienna' }
  let(:weather) { ['weather'] }
  let(:weather_mock_response) { { weather: weather }.to_json }
  let(:expected_url) { "https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{weather_api_key}" }
  let(:not_found_mock) { { "cod": "404", "message": "city not found" }.to_json }
  it "constructs the api url" do
    expect(Net::HTTP).to receive(:get).with(URI.parse(expected_url)).and_return(weather_mock_response)
    WeatherService.call(city)
  end
  it "returns the weather" do
    expect(Net::HTTP).to receive(:get).with(anything).and_return(weather_mock_response)
    returned_weather = WeatherService.call(city)
    expect(returned_weather).to eq(weather)
  end
  it "throws exception when invalid city passed" do
    expect(Net::HTTP).to receive(:get).and_return(not_found_mock)
    expect {
      WeatherService.call('invalid_city')
    }.to raise_error ActionController::BadRequest
  end
end