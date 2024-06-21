class TenantsController < ApplicationController
  def update
    tenant = Tenant.find(params[:id])

    tenant.update!(update_params)
  end

  private

  def update_params
    params.permit(fields_attributes: [:name, :data_type, allowed_values: []])
  end
end
