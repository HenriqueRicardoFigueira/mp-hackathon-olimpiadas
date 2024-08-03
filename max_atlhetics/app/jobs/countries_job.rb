class CountriesJob < ApplicationJob
  queue_as :default

  def perform
    response = OlympicGamesApiService.new.obtain_medals
    response["data"].each do |country|
      CountryBuilder.new(country.with_indifferent_access).build
    end
  end
end
