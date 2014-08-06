class AddPublishTypeToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :publish_type, :integer
  end
end
