class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer :title
      t.integer :category, default: 0

      t.timestamps
    end
  end
end
