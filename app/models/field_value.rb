class FieldValue < ApplicationRecord
  belongs_to :field
  belongs_to :user

  delegate :data_type, to: :field
  delegate :allowed_values, to: :field

  # casting the passed value to String,
  # as the underlying column has String type
  def setter_cast(value)
    case data_type
    when 'text', 'number', 'single_select'
      value.to_s
    when 'multi_select'
      value.to_json
    else
      value
    end
  end

  # casting the stored String value to the expected type
  def getter_cast
    case data_type
    when 'number'
      value.to_f
    when 'multi_select'
      JSON.parse(value)
    else
      value
    end
  end

  # validating inclusion in allowed_values for select type fields
  def validate_value(value)
    if data_type.in?(%w[single_select multi_select]) && !Array(value).all? { |v| allowed_values.map(&:downcase).include?(v.downcase) }
      fail "#{value} is not allowed, allowed values are #{allowed_values}"
    end
  end
end
