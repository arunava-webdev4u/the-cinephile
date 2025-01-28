class UsersController < ApplicationController
    # Skip CSRF token verification since it's an API-only project
    # skip_before_action :verify_authenticity_token
  
    # POST /users
    def create
      @user = User.new(user_params)
  
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # GET /users
    def index
      @users = User.all
      render json: @users
    end

    # GET /users/:id
    def show
      @user = User.find_by(id: params[:id])
  
      if @user
        render json: @user
      else
        render json: { error: "User not found" }, status: :not_found
      end
    end
  
    private
  
    # Only allow a list of trusted parameters through
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :date_of_birth, :country)
    end
  end
  