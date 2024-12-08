class BooksController < ApplicationController
    def new
        @book = Book.new
        @user = current_user
    end

    def create
        @book = Book.new(book_params)
        @user = current_user
        @book.user_id = current_user.id
        @book.save
        redirect_to books_path
    end

    def index
        @books = Book.all
        @book = Book.new
        @user = current_user
    end

    def show
        @book = Book.find(params[:id])
        @user = current_user
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        book =Book.find(params[:id])
        if book.update(book_params)
            flash[:notice] = "Book was successfully updated."
            redirect_to book_path(book.id)
        else
            @book = book
            flash[:notice] = "An error has occurred."
            render :edit 
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end

    private
    def book_params
        params.require(:book).permit(:title, :opinion)
    end
end
