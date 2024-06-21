class UsersController < ApplicationController
  def update_value
    user = User.find(params[:id])

    user.set(update_value_params[:values])
  end

  private

  def update_value_params
    params.permit(values: [:name, :value, value: []])
  end
end
