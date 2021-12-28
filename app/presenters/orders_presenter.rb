class OrdersPresenter < SimpleDelegator
  include ActiveSupport::NumberHelper

  def total
    number_to_currency(super / 100)
  end

  def items
    super.map { |item| item.name.to_s }.join(', ')
  end
end
