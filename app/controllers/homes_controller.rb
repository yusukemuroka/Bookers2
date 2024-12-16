class HomesController < ApplicationController
  def top
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end
  def about
    @user = current_user
    @books = Book.all
    @users = User.all
  end
end
