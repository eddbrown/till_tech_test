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
  end



end