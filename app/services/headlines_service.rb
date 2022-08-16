class HeadlinesService < ApplicationService
  def call
    news_api = News.new(ENV.fetch('NEWS_API_KEY','NEWS_API_KEY NOT FOUND'))
    news_api.get_top_headlines(q: @query)
  end
end
