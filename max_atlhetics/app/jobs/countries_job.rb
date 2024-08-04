class CountriesJob < ApplicationJob
  queue_as :default

  def perform
    page = 1
    loop do
      response = OlympicGamesApiService.new({ page: page }).obtain_medals_by_page
      response["data"].each do |country|
        CountryBuilder.new(country.with_indifferent_access).build
      end

      break if response["meta"]["last_page"] == page
      page += 1
    end
  end
end
