class OlympicGamesApiService < ApplicationService
  BASE_URL = "https://apis.codante.io/olympic-games/"

  def initialize(args = nil)
    @args = args
  end

  def obtain_medals_by_page
    url = "#{BASE_URL}countries?page=#{page}"
    obtain_medals(url)
  end

  private

  def obtain_medals(url)
    response = Utils::HttpRequest.new.get(url)
    JSON.parse(response.body)
  end

  def page
    @args[:page] || 1
  end
end
