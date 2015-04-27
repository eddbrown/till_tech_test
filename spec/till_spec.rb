require 'till'

describe Till do 

  let(:till){Till.new}

  it 'should store an item and a quantity' do
    till.add_entry('Cappucino', 2)
    expect(till.items).to eq(['Cappucino'])
    expect(till.quantity).to eq([2])
  end

  it 'should be able to reset' do
    till.add_entry('Cappucino', 2)
    till.reset!
    expect(till.items).to eq([])
    expect(till.quantity).to eq([])
    expect(till.price).to eq([])
    expect(till.line_total).to eq([])
    expect(till.tax).to eq(0)
    expect(till.pre_tax_total).to eq(0)
    expect(till.total).to eq(0)
  end

  it 'should add the price of the ordered item' do
    till.add_entry('Cappucino', 2)
    expect(till.price).to eq([3.85])
  end

  it 'should calculate the line total amount' do
    till.add_entry('Cappucino', 2)
    expect(till.line_total).to eq([7.70])
  end

  it 'should calculate the total amount' do
    till.add_entry('Cappucino', 2)
    till.add_entry('Choc Mudcake', 2)
    till.compute
    expect(till.pre_tax_total).to eq(20.50)
  end

  it 'should be able to work out the tax' do
    till.add_entry('Cappucino', 2)
    till.add_entry('Choc Mudcake', 1)
    till.compute
    expect(till.tax).to eq((till.pre_tax_total * till.tax_rate).round(2))
  end

  it 'should be able to work out the total' do
    till.add_entry('Cappucino', 2)
    till.compute
    expect(till.total).to eq(till.pre_tax_total + till.tax)
  end

  it 'should calculate the change' do
    till.add_entry('Cappucino', 2)
    till.compute
    till.pay(20)
    till.checkout
    expect(till.change).to eq(20 - till.total)
  end

  context 'discounts' do
    it 'can work out general discounts on orders over a certain amount' do
      till.add_entry('Cappucino', 20)
      till.add_general_discount(0.05, 50)
      till.compute
      expect(till.pre_tax_total).to eq((20 * 3.85 * 0.95).round(2))
    end
  end


end