require "yaml"

module Ranking
  extend Discordrb::Commands::CommandContainer

  Bot.command(:ranking) do |event|
    event.respond fetch_ranking_medals
  end

  def self.fetch_ranking_medals
    countries = Country.top_teen_with_brazil
    MessageService.new(countries: countries).ranking_messages
  end
end
