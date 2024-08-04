
require 'rails_helper'

describe OlympicGamesApiService do
  let(:api_service) { OlympicGamesApiService.new({}) }

  describe '#obtain_medals', vcr: true do
    it 'returns medals for coutries from the first page' do
      response = api_service.obtain_medals_by_page
      expect(response).to be_a(Hash)
      expect(response['data'].count).to eq 50
      expect(response['data'].first['name']).to eq 'China'
    end
  end
end
