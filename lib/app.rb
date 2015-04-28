require 'sinatra/base'
require_relative 'till.rb'
require_relative 'customer.rb'

class App < Sinatra::Base
  till = Till.new
  customer = Customer.new

  get '/' do
    @till = till
    erb :index
  end

  get '/receipt' do
    till.add_entry('Cappucino', 2)
    @items = till.items
    @quantity = till.quantity
    @price = till.price
    @line_total = till.line_total
    till.pay(1000)
    till.checkout
    @payment = till.payment
    @change = till.change
    @pre_tax_total = till.pre_tax_total
    @tax_rate = till.tax_rate * 100
    @tax = till.tax
    @general_discount = till.general_discount["percent"]
    @total = till.total
    erb :receipt
  end

  get '/reset' do
    till.reset!
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
