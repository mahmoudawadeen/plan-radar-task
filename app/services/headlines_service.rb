class HeadlinesService < ApplicationService
  def call
    Rails.cache.fetch("headline:#{@query}", expires_in: ENV.fetch("NEWS_API_CACHE_MINUTES", 30).to_i.minutes) do
      news_api = News.new(ENV.fetch('NEWS_API_KEY', 'NEWS_API_KEY NOT FOUND'))
      news_api.get_top_headlines(q: @query)
    end
  end
end
