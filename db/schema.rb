# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_20_175700) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "field_values", force: :cascade do |t|
    t.bigint "field_id"
    t.bigint "user_id"
    t.string "value"
    t.index ["field_id"], name: "index_field_values_on_field_id"
    t.index ["user_id"], name: "index_field_values_on_user_id"
  end

  create_table "fields", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "name"
    t.integer "data_type", default: 0, null: false
    t.jsonb "allowed_values", default: []
    t.index ["name", "tenant_id"], name: "index_fields_on_name_and_tenant_id", unique: true
    t.index ["name"], name: "index_fields_on_name"
    t.index ["tenant_id"], name: "index_fields_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
  end

  create_table "users", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

end
