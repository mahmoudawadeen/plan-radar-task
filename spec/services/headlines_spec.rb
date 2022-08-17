require 'rails_helper'

describe HeadlinesService, type: :helper do
  let(:news_api_key) { 'NEWS_API_KEY NOT FOUND'}
  let(:city) {'vienna'}
  let(:latest_news) {['news']}
  it "calls news gem with correct params" do
    news_api = News.new(news_api_key)
    expect(ENV).to receive(:fetch).with('NEWS_API_CACHE_MINUTES',anything).and_return(30)
    expect(ENV).to receive(:fetch).with('NEWS_API_KEY',anything).and_return(news_api_key)
    expect(News).to receive(:new).with(news_api_key).and_return(news_api)
    expect(news_api).to receive(:get_top_headlines).with(q: city)
    HeadlinesService.call(city)
  end
  it "returns the news" do
    news_api = News.new(news_api_key)
    expect(News).to receive(:new).with(news_api_key).and_return(news_api)
    expect(news_api).to receive(:get_top_headlines).with(q: city).and_return(latest_news)
    returned_news = HeadlinesService.call(city)
    expect(returned_news).to eq(latest_news)
  end
end