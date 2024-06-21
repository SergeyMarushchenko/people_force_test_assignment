class Field < ApplicationRecord
  belongs_to :tenant
  has_many :filed_values
  enum data_type: [:text, :number, :single_select, :multi_select]

  validates_presence_of :name, :data_type
  # allowed_values Array is required for select type fields
  validates_presence_of :allowed_values, if: :is_select_type?, message: :required

  def is_select_type?
    data_type.in?(%w[single_select, multi_select])
  end
end
