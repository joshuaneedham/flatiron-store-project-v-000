class Cart < ActiveRecord::Base
end

class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def add_item(item)
    self.line_items.where(:item_id => item).first || self.line_items.build(:item_id => item)
  end

  def total
    total = 0
    self.line_items.each do |line_item|
      item = Item.find(line_item.item_id)
      total += (item.price * line_item.quantity)
    end
    total
  end
end
