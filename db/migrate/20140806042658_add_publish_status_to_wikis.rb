class AddPublishStatusToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :publish, :boolean
    add_column :wikis, :draft, :boolean
    add_column :wikis, :scheduled, :datetime

    add_index :wikis, :draft
    add_index :wikis, :scheduled
  end
end
