require 'rails_helper'

RSpec.describe CountriesJob, type: :job do
  describe '#perform' do
    let(:api_service) { instance_double(OlympicGamesApiService) }
    let(:country_builder) { instance_double(CountryBuilder) }

    let(:response_page_1) do
      {
        "data" => [
          {
            "name" => "United States",
            "gold_medals" => 39,
            "silver_medals" => 41,
            "bronze_medals" => 33,
            "total_medals" => 113,
            "rank" => 1,
            "rank_total_medals" => 113,
            "continent" => "North America",
            "flag_url" => "https://www.countryflags.io/US/flat/64.png"
          }
        ],
        "meta" => {
          "current_page" => 1,
          "last_page" => 2
        }
      }
    end

    let(:response_page_2) do
      {
        "data" => [
          {
            "name" => "Canada",
            "gold_medals" => 11,
            "silver_medals" => 8,
            "bronze_medals" => 10,
            "total_medals" => 29,
            "rank" => 10,
            "rank_total_medals" => 29,
            "continent" => "North America",
            "flag_url" => "https://www.countryflags.io/CA/flat/64.png"
          }
        ],
        "meta" => {
          "current_page" => 2,
          "last_page" => 2
        }
      }
    end

    before do
      allow(OlympicGamesApiService).to receive(:new).and_return(api_service)
      allow(api_service).to receive(:obtain_medals_by_page).and_return(response_page_1, response_page_2)
      allow(CountryBuilder).to receive(:new).and_return(country_builder)
      allow(country_builder).to receive(:build)
    end

    it 'calls the OlympicGamesApiService to obtain medals for all pages' do
      described_class.perform_now

      expect(api_service).to have_received(:obtain_medals_by_page).twice
    end

    it 'calls the CountryBuilder to build countries from all pages' do
      described_class.perform_now

      expect(CountryBuilder).to have_received(:new).with(response_page_1["data"][0].with_indifferent_access)
      expect(CountryBuilder).to have_received(:new).with(response_page_2["data"][0].with_indifferent_access)
      expect(country_builder).to have_received(:build).twice
    end
  end
end
