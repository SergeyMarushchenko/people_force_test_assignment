class AddUsersAndTenantsTables < ActiveRecord::Migration[7.1]
  def change
    create_table :tenants

    create_table :users do |t|
      t.references :tenant, null: false, index: true
    end

    create_table :fields do |t|
      t.references :tenant, index: true, null: false
      t.string :name, index: true
      t.integer :data_type, null: false, default: 0
      t.jsonb :allowed_values, default: []
    end

    add_index :fields, [:name, :tenant_id], unique: true

    create_table :field_values do |t|
      t.references :field, index: true
      t.references :user, index: true
      t.string :value
    end
  end
end
