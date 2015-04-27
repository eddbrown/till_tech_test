require 'customer'
require 'json'

describe Customer do 
  let(:customer) {Customer.new}
  let(:till) {double :till}

  it 'should be able to send an order to the till' do
    expect(till).to receive(:add_entry).with('Cappucino', 2)
    customer.order(till, 'Cappucino', 2)
  end

  it 'should only be able to ask for items on the menu' do
    allow(till).to receive(:add_entry).with('erroneous item', 2)
    expect{customer.order(till, 'erroneous item', 2)}.to raise_error('not on menu')
  end
end