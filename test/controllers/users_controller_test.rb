require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should update fields from params" do
    tenant = Tenant.create!

    fields_attributes = [
      { name: 'First Name', data_type: 'text' },
      { name: 'Last Name', data_type: 'text' },
      { name: 'age', data_type: 'number' },
      { name: 'city of birth', data_type: 'single_select', allowed_values: %w[London Paris] },
      { name: 'hobbies', data_type: 'multi_select', allowed_values: %w[Jogging Swimming Skiing] }
    ]

    tenant.update!({ fields_attributes: fields_attributes })

    user = User.create!(tenant: tenant)

    values = [
      { name: 'First Name', value: 'John' },
      { name: 'Last Name', value: 'Doe' },
      { name: 'age', value: 50 },
      { name: 'city of birth', value: 'London' },
      { name: 'hobbies', value: %w[Jogging Swimming] }
    ]

    put update_value_user_url(user), params: { values: values }

    assert_response :success
    assert_equal 5, user.field_values.count
    assert_equal 'John', user.get('First Name')
    assert_equal 'Doe', user.get('Last Name')
    assert_equal 50, user.get('age')
    assert_equal 'London', user.get('city of birth')
    assert_equal %w[Jogging Swimming], user.get('hobbies')
  end
end
