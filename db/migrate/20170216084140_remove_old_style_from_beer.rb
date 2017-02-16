class RemoveOldStyleFromBeer < ActiveRecord::Migration[5.0]
  def change
    remove_column :beers, :old_style
  end
end
