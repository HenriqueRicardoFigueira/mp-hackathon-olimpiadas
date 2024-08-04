
require 'rails_helper'

RSpec.describe Country, type: :model do
  describe "#scopes" do
    describe ".ranked" do
      it "returns the countries with rank" do
        create(:country, rank: 1)
        create(:country, rank: 0)

        ranked = Country.ranked
        expect(ranked.count).to eq(1)
        expect(ranked.first.rank).to eq(1)
      end
    end

    describe ".ranked_by_total_medals" do
      it "returns the countries with rank_total_medals" do
        create(:country, rank_total_medals: 1)
        create(:country, rank_total_medals: 0)

        ranked_by_total_medals = Country.ranked_by_total_medals
        expect(ranked_by_total_medals.count).to eq(1)
        expect(ranked_by_total_medals.first.rank_total_medals).to eq(1)
      end
    end
  end

  describe "#top_teen" do
    it "returns the top 10 countries" do
      1..12.times do |i|
        create(:country, rank: i)
      end

      top_teen = Country.top_teen

      expect(top_teen.count).to eq(10)
      expect(top_teen.first.rank).to eq(1)
      expect(top_teen.last.rank).to eq(10)
    end
  end

  describe "#top_ten_by_total_medals" do
    it "returns the top 10 countries by total medals" do
      1..13.times do |i|
        create(:country, rank_total_medals: i)
      end

      top_ten_by_total_medals = Country.top_ten_by_total_medals

      expect(top_ten_by_total_medals.count).to eq(10)
      expect(top_ten_by_total_medals.first.rank_total_medals).to eq(1)
      expect(top_ten_by_total_medals.last.rank_total_medals).to eq(10)
    end
  end

  describe "#brazil" do
    it "returns the Brazil country" do
      create(:country, name: "Argentina", rank: 2)
      create(:country, name: "Brasil", rank: 1)

      brazil = Country.brazil

      expect(brazil.name).to eq("Brasil")
      expect(brazil.rank).to eq(1)
    end
  end

  describe "#top_teen_with_brazil" do
    context "when Brazil is not in the top 10" do
    it "returns the top 10 countries and Brazil" do
      1..12.times do |i|
        create(:country, name: "x=#{i}", rank: i)
      end

      create(:country, name: "Brasil", rank: 188)

      top_teen_with_brazil = Country.top_teen_with_brazil

      expect(top_teen_with_brazil.count).to eq(11)
      expect(top_teen_with_brazil.pluck(:name)).to include("Brasil")
    end
  end
  end

  context "when Brazil is in the top 10" do
    it "returns the top 10 countries" do
      1..12.times do |i|
        create(:country, name: "x=#{i}", rank: i)
      end

      create(:country, name: "Brasil", rank: 1)

      top_teen_with_brazil = Country.top_teen_with_brazil

      expect(top_teen_with_brazil.count).to eq(10)
      expect(top_teen_with_brazil.pluck(:name)).to include("Brasil")
    end
  end

  describe "#top_ten_by_total_medals_with_brazil" do
    context "when Brazil is not in the top 10" do
    it "returns the top 10 countries and Brazil" do
      1..12.times do |i|
        create(:country, name: "x=#{i}", rank_total_medals: i)
      end

      create(:country, name: "Brasil", rank_total_medals: 188)

      top_ten_by_total_medals_with_brazil = Country.top_ten_by_total_medals_with_brazil

      expect(top_ten_by_total_medals_with_brazil.count).to eq(11)
      expect(top_ten_by_total_medals_with_brazil.pluck(:name)).to include("Brasil")
    end
  end
  end

  context "when Brazil is in the top 10" do
    it "returns the top 10 countries" do
      1..12.times do |i|
        create(:country, name: "x=#{i}", rank_total_medals: i)
      end

      create(:country, name: "Brasil", rank_total_medals: 1)

      top_ten_by_total_medals_with_brazil = Country.top_ten_by_total_medals_with_brazil

      expect(top_ten_by_total_medals_with_brazil.count).to eq(10)
      expect(top_ten_by_total_medals_with_brazil.pluck(:name)).to include("Brasil")
    end
  end
end
