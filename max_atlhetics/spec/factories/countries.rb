FactoryBot.define do
  factory :country do
    name { "MyString" }
    gold_medals { 1 }
    silver_medals { 1 }
    bronze_medals { 1 }
    total_medals { 1 }
    rank { 1 }
    rank_total_medals { 1 }
    continent { "MyString" }
    flag_url { "MyString" }
  end
end
