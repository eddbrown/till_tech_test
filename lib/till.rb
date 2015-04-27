class Till

  attr_accessor :items
  attr_accessor :quantity

  def initialize
    @items = Array.new
    @quantity = Array.new
  end

  def add_entry item, quantity
    @items.push item
    @quantity.push quantity
  end

  def reset!
    initialize
  end

end