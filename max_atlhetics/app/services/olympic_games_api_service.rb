class OlympicGamesApiService < ApplicationService
  BASE_URL = "https://apis.codante.io/olympic-games/"

  def initialize(args)
    @args = args
  end

  def obtain_medals
    Utils::HttpRequest.new.get("#{BASE_URL}countries")
  end
end
