class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :article_id
      t.integer :user_is
      t.string :content
      t.string :status

      t.timestamps null: false
    end
  end
end
