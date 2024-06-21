# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

tenant = Tenant.create!
3.times { User.create!(tenant: tenant) }
Field.create!(name: :first_name, data_type: :text, tenant: tenant)
Field.create!(name: :last_name, data_type: :text, tenant: tenant)
Field.create!(name: :age, data_type: :number, tenant: tenant)
Field.create!(name: :city_of_birth, data_type: :single_select, tenant: tenant, allowed_values: %w[London, Paris])
Field.create!(name: :hobbies, data_type: :multi_select, tenant: tenant, allowed_values: %w[Jogging, Swimming, Skiing])
