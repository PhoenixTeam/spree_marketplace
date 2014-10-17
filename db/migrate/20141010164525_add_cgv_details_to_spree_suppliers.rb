class AddCgvDetailsToSpreeSuppliers < ActiveRecord::Migration
  def change
    add_column :spree_suppliers, :agreed_cgv, :boolean, default: false, null: false
    add_column :spree_suppliers, :siret, :integer
  end
end
