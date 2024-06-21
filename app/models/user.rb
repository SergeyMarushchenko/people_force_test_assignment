class User < ApplicationRecord
  belongs_to :tenant
  has_many :fields, through: :tenant
  has_many :field_values

  # setter method, accepts hash of shape { name:, value: }
  # or Array of such hashes
  def set(values)
    ActiveRecord::Base.transaction do
      Array.wrap(values).each do |v|
        field_value = field_values.find_or_create_by(field_id: field_id(v['name']))
        field_value.validate_value(v['value'])
        field_value.update!(value: field_value.setter_cast(v['value']))
      end
    end
  end

  # getter method, returns value by it's name
  def get(name)
    field_value = field_values.find_or_create_by(field_id: field_id(name))
    field_value.getter_cast
  end

  private

  def field_id(name)
    field = fields.find_by(name: name)

    raise "Field #{name} is not defined on your tenant" unless field

    field.id
  end
end
