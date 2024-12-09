class BooksController < ApplicationController

    def new
        @book = Book.new
        @user = current_user
    end

    def create
        @book = Book.new(book_params)
        @books = Book.all
        @user = current_user
        @book.user_id = current_user.id
        if @book.save
        flash[:notice] = "You have created book successfully."
        redirect_to book_path(@book.id)
        elsif @book.title==""
            flash.now[:notice] = "can't be blank"
            render :index
        else
        flash.now[:notice] = "An error has occured."
        render :index
    end
    end

    def index
        @books = Book.all
        @book = Book.new
        @user = current_user
    end

    def show
        @book = Book.find(params[:id])
        @user = @book.user
    end

    def edit
        @book = Book.find(params[:id])
        @user = current_user
        unless @book.user.id == current_user.id
            redirect_to books_path
          end
    end

    def update
        book =Book.find(params[:id])
        if book.update(book_params)
            flash[:notice] = "Book was successfully updated."
            redirect_to book_path(book.id)
        else
            @book = book
            @user = current_user
            flash.now[:notice] = "An error has occurred."
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
        params.require(:book).permit(:title, :body)
    end
end
