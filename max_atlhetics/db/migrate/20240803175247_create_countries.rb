class CreateCountries < ActiveRecord::Migration[7.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.integer :gold_medals
      t.integer :silver_medals
      t.integer :bronze_medals
      t.integer :total_medals
      t.integer :rank
      t.integer :rank_total_medals
      t.string :continent
      t.string :flag_url

      t.timestamps
    end
  end
end
