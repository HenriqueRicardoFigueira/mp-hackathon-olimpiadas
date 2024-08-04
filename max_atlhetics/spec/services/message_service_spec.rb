require 'rails_helper'

describe MessageService do
  describe "#ranking_messages" do
    it "returns the ranking of medals" do
      countries = [ create(:country, rank: 1, name: "Brasil", total_medals: 10) ]
      service = MessageService.new(countries: countries)

      expect(service.ranking_messages).to eq("Ranking medalhas de ouro:\n1º - 🇧🇷 Brasil 🥇 10 medalhas")
    end
  end

  describe "#ranking_total_medals_message" do
    it "returns the ranking of total medals" do
      countries = [ double(:country, rank: 1, name: "Brasil", total_medals: 10) ]
      service = MessageService.new(countries: countries)

      expect(service.ranking_total_medals_message).to eq("Ranking total de medalhas:\n1º - 🇧🇷 Brasil 🥇 10 medalhas")
    end
  end
end
