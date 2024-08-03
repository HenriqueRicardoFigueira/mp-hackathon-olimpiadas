
  class CountryBuilder
    def initialize(params)
      @params = params
    end

    attr_reader :params

    def build
      country = Country.find_or_initialize_by(name: params[:name])
      country.update!(
        gold_medals: params[:gold_medals],
        silver_medals: params[:silver_medals],
        bronze_medals: params[:bronze_medals],
        total_medals: params[:total_medals],
        rank: params[:rank],
        rank_total_medals: params[:rank_total_medals],
        continent: params[:continent],
        flag_url: params[:flag_url]
      )
    end
  end
