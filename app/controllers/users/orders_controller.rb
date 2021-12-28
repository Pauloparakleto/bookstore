module Users
  class OrdersController < ApplicationController
    # TODO, Only user orders list.
    before_action :new_book_session, except: [:create]

    def cart
      @order = Order.new
      session[:book_ids].each do |book_id|
        book = Book.find(book_id)
        @order.items.build({ name: book.title, price: book.price,
                             quantity: 1, book_id: book_id })
      end
      @order
    end

    def show
      @order = Order.find(params[:id])
    end

    def create
      @order = Order.new(order_params)
      if @order.save
        reset_session
        redirect_to users_order_path(@order), notice: 'Order Created!'
      else
        render 'users/cart/index', alert: 'Order not Processed!'
      end
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

    def order_params
      params.require(:order).permit(items_attributes: [:name, :price, :quantity, :book_id])
    end
  end
end
