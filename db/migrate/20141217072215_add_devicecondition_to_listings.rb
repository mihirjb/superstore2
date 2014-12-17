class AddDeviceconditionToListings < ActiveRecord::Migration
  def change
    add_column :listings, :devicecondition, :string
  end
end
