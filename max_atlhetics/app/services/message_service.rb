class MessageService < ApplicationService
  FLAGS_ICONS = YAML.load_file(Rails.root.join("config", "flags.yml"))

  def initialize(args)
    @args = args
  end

  def ranking_messages
    "Ranking medalhas de ouro:\n#{create_ranking_message.join("\n")}"
  end

  def ranking_total_medals_message
    "Ranking total de medalhas:\n#{create_ranking_message.join("\n")}"
  end

  private

  def create_ranking_message
    countries.each.map do |country|
      flag = obtain_flag_icon(country.name)
      "#{country.rank}º - #{flag} #{country.name} 🥇 #{country.total_medals} medalhas"
    end
  end

  def countries
    @args[:countries]
  end

  def obtain_flag_icon(country)
    FLAGS_ICONS[normalize_string(country)]  || "🌍"
  end

  def normalize_string(str)
    ActiveSupport::Inflector.transliterate(str.downcase.strip)
  end
end
