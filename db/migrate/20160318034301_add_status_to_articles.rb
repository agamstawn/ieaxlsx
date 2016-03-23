class AddStatusToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :status, :string
    add_column :articles, :status_two, :string
  end
end
