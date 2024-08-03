require 'rails_helper'

describe CountryBuilder do
  describe '#build' do
    let(:country) { create(:country) }
    let(:params) do
      {
        name: 'United States',
        gold_medals: 39,
        silver_medals: 41,
        bronze_medals: 33,
        total_medals: 113,
        rank: 1,
        rank_total_medals: 113,
        continent: 'North America',
        flag_url: 'https://www.countryflags.io/US/flat/64.png'
      }
    end

    it 'creates a new country' do
      expect { described_class.new(params).build }.to change(Country, :count).by(1)
    end

    it 'updates an existing country' do
      country.update!(name: 'United States')
      expect { described_class.new(params).build }.to change(Country, :count).by(0)
    end
  end
end
