require "test_helper"

class TenantsControllerTest < ActionDispatch::IntegrationTest
  test "should create fields from params" do
    tenant = Tenant.create!

    fields_attributes = [
      { name: 'First Name', data_type: 'text' },
      { name: 'Last Name', data_type: 'text' },
      { name: 'age', data_type: 'number' },
      { name: 'city of birth', data_type: 'single_select', allowed_values: %w[London, Paris] },
      { name: 'hobbies', data_type: 'multi_select', allowed_values: %w[Jogging, Swimming, Skiing] }
    ]

    put tenant_url(tenant), params: { fields_attributes: fields_attributes }

    assert_response :success
    assert_equal 5, tenant.fields.count
  end
end
