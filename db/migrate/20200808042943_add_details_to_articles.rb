class AddDetailsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :hashbody, :text, default: ''
  end
end
