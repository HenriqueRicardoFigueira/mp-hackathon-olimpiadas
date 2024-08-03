class OlympicGamesApiService < ApplicationService
  BASE_URL = "https://apis.codante.io/olympic-games/"

  def initialize(args = nil)
    @args = args
  end

  def obtain_medals
    response = Utils::HttpRequest.new.get("#{BASE_URL}countries")
    JSON.parse(response.body)
  end
end
