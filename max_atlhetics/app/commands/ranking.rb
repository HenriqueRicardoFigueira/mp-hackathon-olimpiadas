require "yaml"

module Ranking
  extend Discordrb::Commands::CommandContainer
  puts "Registrando comando !ranking"
  FLAGS_ICONS = YAML.load_file(Rails.root.join("config", "flags.yml"))

  Bot.command(:ranking) do |event|
    event.respond fetch_ranking_medals
  end

  def self.fetch_ranking_medals
    Rails.cache.clear
    brasil = Country.find_by(name: "Brasil")
    ranking = Country.where.not(rank: 0).order(rank: :asc).limit(10).each.map do |country|
      flag = obtain_flag_icon(country.name)
      "#{country.rank}º - #{flag} #{country.name} 🥇 #{country.total_medals} medalhas"
    end
    ranking << "#{brasil.rank}º - 🇧🇷 Brasil 🥇 #{brasil.total_medals} medalhas"
    "Ranking de medalhas\n#{ranking.join("\n")}"
  end

  def self.obtain_flag_icon(country)
    FLAGS_ICONS[normalize_string(country)]  || "🌍"
  end

  def self.normalize_string(str)
    ActiveSupport::Inflector.transliterate(str.downcase.strip)
  end
end
