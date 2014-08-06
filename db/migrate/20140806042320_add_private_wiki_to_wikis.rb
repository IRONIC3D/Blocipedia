class AddPrivateWikiToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :private, :boolean, default: false
  end
end
