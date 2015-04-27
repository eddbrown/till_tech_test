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
    till.checkout
    expect(till.pre_tax_total).to eq(20.50)
  end

  it 'should be able to work out the tax' do
    till.add_entry('Cappucino', 2)
    till.add_entry('Choc Mudcake', 1)
    till.checkout
    expect(till.tax).to eq(till.pre_tax_total * till.tax_rate)
  end

  it 'should be able to work out the total' do
    till.add_entry('Cappucino', 2)
    till.checkout
    expect(till.total).to eq(till.pre_tax_total + till.tax)
  end


end