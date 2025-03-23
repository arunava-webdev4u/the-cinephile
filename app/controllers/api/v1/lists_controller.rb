class Api::V1::ListsController < Api::V1::BaseController
    def index
        user_id = 1         # for now, create for user_id = 1

        render json: { message: "Invalid user_id"}, status: :unprocessable_entity unless user_id

        @lists = List.where(user_id: user_id)

        if @lists
            render json: @lists, status: :ok
        else
            render json: @lists.errors, status: :not_found
        end
    end

    def show
        list_id = params[:id]
        @list = List.find(list_id)
        render json: @list, status: :ok

    rescue ActiveRecord::RecordNotFound
        render json: { message: "List Not Found"}, status: :not_found
    end

    def create
        new_list = CustomList.new(permitted_params)
        new_list.user_id = 1            # for now, create for user_id = 1

        if new_list.save!
            render json: new_list, status: :created
        else
            render json: { message: "Can't Create"}, status: :unprocessable_entity
        end
    end

    def destroy
        list_id = params[:id]
        list = CustomList.find(list_id)
        list.delete
        render json: { message: "List Deleted" }, status: :ok
    end

    def update
        list_id = params[:id]
        list = CustomList.find(list_id)
        list.name = params[:list][:name]
        list.description = params[:list][:description]
        list.save
        render json: { message: "List Updated" }, status: :ok
    end
    
    private

    def permitted_params
        params.require(:list).permit(:name, :description)
    end
end