class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :decrement_product_quantity

  def decrement_product_quantity
    line_items = LineItem.includes(:product).where(order_id: id)

    line_items.each do |item|
      product = Product.find(item.product_id)
      product.decrement!(:quantity, by = 1)
    end
  end
end
