class Till

  attr_accessor :items
  attr_accessor :price
  attr_accessor :quantity
  attr_reader :line_total
  attr_reader :pre_tax_total
  attr_reader :tax
  attr_reader :tax_rate
  attr_reader :total

  def initialize
    @tax_rate = 1.0864
    @items = Array.new
    @quantity = Array.new
    @price = Array.new
    @line_total = Array.new
    path = File.expand_path('../../hipstercoffee.json', __FILE__)
    @menu = JSON.parse(File.read(path))
  end

  def add_entry item, quantity
    @items.push item
    @quantity.push quantity
    price = @menu[0]['prices'][0][item]
    @price.push price
    @line_total.push price * quantity
  end

  def reset!
    initialize
  end

  def checkout
    @pre_tax_total = line_total.inject(:+)
    @tax = @tax_rate * @pre_tax_total
    @total = @pre_tax_total + @tax
  end

end