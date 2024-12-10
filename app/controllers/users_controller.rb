class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]  
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
        @user = User.find(params[:id])
        @books = @user.books
        @book = Book.new
      end

      def index
        @users = User.all
        @user = current_user
        @book = Book.new
      end
    
      def edit
        @user = User.find(params[:id])
        @book = Book.new
      end
    
      def update
        @user = User.find(params[:id])
        @book = Book.new
        if @user.update(user_params)
        flash[:notice] = "User was successfully updated."
        redirect_to user_path(@user.id)
        elsif user_params[:name].length < 2
          flash[:notice] = "Name is too short (minimum is 2 characters)."
          render :edit
        elsif user_params[:name].length > 20
          flash[:notice] = "Name is too long (maximum is 20 characters)"
          render :edit
        else
            flash[:notice] = "An error has occurred."
            render :edit
        end
      end
    
      private
      def user_params
        params.require(:user).permit(:name,:introduction,:profile_image)
      end
    
      def is_matching_login_user
        user = User.find(params[:id])
        unless user.id == current_user.id
          redirect_to user_path(current_user.id)
        end
      end
      def ensure_correct_user
        @user = User.find(params[:id])
        unless current_user == @user || current_user.admin?
          flash[:alert] = "You are not authorized to edit this user."
          redirect_to root_path
        end
      end
end
    
