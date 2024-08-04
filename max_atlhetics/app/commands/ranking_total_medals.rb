
module RankingTotalMedals
  extend Discordrb::Commands::CommandContainer

  Bot.command(:ranking_total_medals) do |event|
    event.respond fetch_ranking_medals
  end

  def self.fetch_ranking_medals
    countries = Country.top_ten_by_total_medals_with_brazil
    MessageService.new(countries: countries, type: 'total').ranking_total_medals_message
  end
end
