class AddPrivateIndexToWikis < ActiveRecord::Migration
  def change
    add_index :wikis, :private
  end
end
