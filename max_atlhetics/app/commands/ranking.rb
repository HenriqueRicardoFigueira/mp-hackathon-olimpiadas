module Ranking
  extend Discordrb::Commands::CommandContainer

  Bot.command(:ranking) do |event|
    event.respond fetch_ranking_medals
  end

  Bot.message(content: "ranking") do |event|
    event.respond fetch_ranking_medals
  end

  def self.fetch_ranking_medals
    brasil = Country.find_by(name: "Brasil")
    ranking = Country.order(rank: :asc).limit(10).each.map do |country|
       "#{country.rank} - #{country.name} 🥇 #{country.total_medals} medalhas ![](#{country.flag_url})"
    end

    "Ranking de medalhas\n#{ranking.join("\n")}"
  end
end
