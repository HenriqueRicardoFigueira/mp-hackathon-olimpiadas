require 'rails_helper'

RSpec.describe CountriesJob, type: :job do
  describe '#perform' do
    let(:api_service) { instance_double(OlympicGamesApiService) }
    let(:country_builder) { instance_double(CountryBuilder) }
    let(:response) do
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
        ]
      }
    end

    before do
      allow(OlympicGamesApiService).to receive(:new).and_return(api_service)
      allow(api_service).to receive(:obtain_medals).and_return(response)
      allow(CountryBuilder).to receive(:new).and_return(country_builder)
      allow(country_builder).to receive(:build)
    end

    it 'calls the OlympicGamesApiService to obtain medals' do
      expect(api_service).to receive(:obtain_medals)
     described_class.perform_later
    end

    it 'calls the CountryBuilder to build countries' do
      expect(CountryBuilder).to receive(:new).with(response["data"][0].with_indifferent_access)
      expect(country_builder).to receive(:build)
      described_class.perform_later
    end
  end
end
