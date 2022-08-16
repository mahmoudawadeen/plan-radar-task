class ApplicationService
  def initialize(query)
    @query = query
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end
end