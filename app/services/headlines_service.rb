class HeadlinesService < ApplicationService
  def call
    news_api = News.new(ENV.fetch("NEWS_API_KEY"))
    news_api.get_top_headlines(q: @query)
  end
end
