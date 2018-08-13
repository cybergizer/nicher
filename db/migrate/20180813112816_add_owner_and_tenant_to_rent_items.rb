class AddOwnerAndTenantToRentItems < ActiveRecord::Migration[5.2]
  def change
    add_column :rent_items, :owner_id, :integer
    add_column :rent_items, :owner_type, :string
    add_column :rent_items, :tenant_id, :integer
    add_column :rent_items, :tenant_type, :string
  end
end
