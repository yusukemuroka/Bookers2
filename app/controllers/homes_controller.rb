class HomesController < ApplicationController
  def top
    if user_signed_in?
    @user = current_user
    @book = Book.new
    @books = current_user.books
    else
    end
  end
end
