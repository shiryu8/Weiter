class CreateHashtagArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_articles do |t|
      t.references :article, foreign_key: true
      t.references :hashtag, foreign_key: true

      t.timestamps
    end
  end
end
