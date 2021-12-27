module Users
  class OrdersController < ApplicationController
    # TODO, Only user orders list.
    before_action :new_book_session

    def cart
      @order = Order.new
      session[:book_ids].each do |book_id|
        book = Book.find(book_id)
        @order.items.build({ name: book.title, price: book.price,
                             quantity: 1, book_id: book_id })
      end
      @order
    end

    def add_book
      return if session[:book_ids].any? params[:book][:id]

      session[:book_ids] << params[:book][:id]
      redirect_to users_books_path
    end

    def remove_book
      session[:book_ids].delete(params[:book_id])
      redirect_to cart_users_orders_path
    end

    private

    def new_book_session
      session[:book_ids] = [] if session[:book_ids].blank?
    end
  end
end
