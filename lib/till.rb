require 'json'

class Till

  attr_accessor :items
  attr_accessor :price
  attr_reader :quantity
  attr_reader :line_total
  attr_reader :pre_tax_total
  attr_reader :tax
  attr_reader :tax_rate
  attr_reader :total
  attr_reader :payment
  attr_reader :change
  attr_reader :menu
  attr_reader :general_discount

  def initialize
    @payment = 0
    @total = 0
    @change = 0
    @tax = 0
    @pre_tax_total = 0
    @general_discount = {"percent" => 0, "minimum_spend" => 0}
    @tax_rate = 0.0864
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

  def compute
    line_total_sum = line_total.inject(:+).round(2)
    if line_total_sum >= @general_discount["minimum_spend"]
      @pre_tax_total = ((1 - @general_discount["percent"]) * line_total_sum).round(2)
    else
      @pre_tax_total = line_total_sum
    end
    @tax = (@tax_rate * @pre_tax_total).round(2)
    @total = (@pre_tax_total + @tax).round(2)
  end

  def pay money
    @payment = money.round(2)
  end

  def checkout
    compute
    @change = @payment - @total
  end

  def add_general_discount percent, minimum_spend
    @general_discount = {"percent" => percent, "minimum_spend" => minimum_spend}
  end

end