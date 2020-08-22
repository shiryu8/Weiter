class AddSoccerToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :good_point, :text
    add_column :articles, :opponent_team, :string
    add_column :articles, :improvement_point, :text
    add_column :articles, :next_challenge, :text
  end
end
