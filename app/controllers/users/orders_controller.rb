module Users
  class OrdersController < Users::UsersController
    before_action :new_book_session, except: [:create]
    before_action :build_order, only: :create

    def cart
      shoppin_cart = ShoppingCart.new(books_in_the_shopping_cart)
      shoppin_cart.build_order
      @order = shoppin_cart.order
    end

    def show
      @order = current_user.orders.find(params[:id])
    end

    def create
      if @order.save
        redirect_to users_order_path(@order), notice: 'Order Created!'
      else
        render 'users/orders/cart', alert: 'Order not Processed!'
      end
    end

    def add_book
      session[:book_ids] << params[:book][:id]
      redirect_to users_books_path
    end

    def remove_book
      session[:book_ids].delete(params[:book_id])
      redirect_to cart_users_orders_path
    end

    private

    def build_order
      session[:book_ids] = []
      @order = current_user.orders.build(order_params)
    end

    def new_book_session
      session[:book_ids] = [] if session[:book_ids].blank?
    end

    def order_params
      params.require(:order).permit(items_attributes: [:name, :price, :quantity, :book_id])
    end

    def books_in_the_shopping_cart
      session[:book_ids]
    end
  end
end
