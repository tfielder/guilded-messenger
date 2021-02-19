class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # corresponds to POST api/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { "status": "success" }, status: 200
    else
      render json: {}, status: 401
    end
  end

  # corresponds to GET api/users/:id
  def show
    render json: get_user()
  end

  # corresponds to GET api/users
  def index
    render json: User.all
  end

  # corresponds to DELETE api/users/:id
  def destroy
    get_user().delete
  end

  private

  def get_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end