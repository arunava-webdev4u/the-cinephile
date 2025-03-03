class Api::V1::ListsController < Api::V1::BaseController
    def index
        puts "==================#{user_id}=========="
        render json: { message: "Invalid user_id"}, status: :unprocessable_entity unless user_id

        @lists = List.where(user_id: user_id)

        if @lists
            render json: @lists, status: :ok
        else
            render json: @lists.errors, status: :not_found
        end
    end
    
    private

    def user_id
        params.require(:user_id)
    end
end