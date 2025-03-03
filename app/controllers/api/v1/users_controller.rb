class Api::V1::UsersController < Api::V1::ApplicationController
    # Skip CSRF token verification since it's an API-only project
    # skip_before_action :verify_authenticity_token

    def index
      @users = User.all
      if @users
        render json: @users, status: :ok
      else
        render json: @users.errors, status: :not_found
      end
    end

    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def show
      @user = User.find_by(id: params[:id])

      if @user
        render json: @user
      else
        render json: { error: "User not found" }, status: :not_found
      end
    end

    # def update
    # end

    # def delete
    # end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :date_of_birth, :country)
    end
end
