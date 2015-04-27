class Customer

  def initialize
    path = File.expand_path('../../hipstercoffee.json', __FILE__)
    @menu = JSON.parse(File.read(path))
  end

  def order till, item, quantity
    raise 'not on menu' if !@menu[0]["prices"][0].has_key?(item)
    till.add_entry(item, quantity)
  end

end