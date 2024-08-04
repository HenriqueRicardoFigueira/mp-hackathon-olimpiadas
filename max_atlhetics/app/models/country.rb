class Country < ApplicationRecord
  scope :ranked, -> { where.not(rank: 0).order(rank: :asc) }
  scope :ranked_by_total_medals, -> { where.not(rank_total_medals: 0).order(rank_total_medals: :asc) }

  def self.top_teen
    ranked.limit(10)
  end

  def self.top_ten_by_total_medals
    ranked_by_total_medals.limit(10)
  end

  def self.brazil
    find_by(name: "Brasil")
  end

  def self.top_teen_with_brazil
    tt = top_teen.to_a
    tt.pluck(:name).include?("Brasil") ? tt : tt << brazil
  end

  def self.top_ten_by_total_medals_with_brazil
    tt = top_ten_by_total_medals.to_a
    tt.pluck(:name).include?("Brasil") ? tt : tt << brazil
  end
end
