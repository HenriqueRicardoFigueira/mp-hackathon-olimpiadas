
require 'rails_helper'

describe OlympicGamesApiService do
  let(:api_service) { OlympicGamesApiService.new({}) }

  describe '#obtain_medals', vcr: true do
    it 'returns medals for all coutries' do
      response = api_service.obtain_medals
      expect(response).to be_a(Hash)
      expect(response['data'].count).to eq 50
      expect(response['data'].first['name']).to eq 'China'
    end
  end
end
