require_relative 'spec_helper.rb'

describe Card do
  it "returns the color of the card" do
    expect(Card.new("heart", "Q").color).to eq 'heart'
  end

  it "returns the value of the card" do
    expect(Card.new("heart", "Q").value).to eq 'Q'
  end

  it "returns the card" do
    card =  {:heart => 'Q'}
    expect(Card.new("heart", "Q").card).to eq card
  end

  it 'prints the card humanized' do
    card = Card.new("heart", "Q")

    expect(card.humanize).to eq "Q of hearts"
  end

  context 'comparing cards with operator <=>' do
    before(:all) do
      @card1 = Card.new('club', 'J')

    end

    it 'returns 0 for equal cards' do
      expect(Card.new('club', 'J') <=> @card1).to eq 0
    end

    it 'returns 1 for when first card is bigger' do
      expect(Card.new('club', 'Q') <=> @card1).to eq 1
    end

    it 'returns -1 for when first card is smaller' do
      expect(Card.new('club', '9') <=> @card1).to eq -1
    end
  end

  context 'comparing cards with operators <, >, ==' do
    before(:all) do
      @card1 = Card.new('club', 'J')

    end

    it 'returns 0 for equal cards' do
      expect(Card.new('club', 'J') == @card1).to eq true
    end

    it 'returns 1 for when first card is bigger' do
      expect(Card.new('club', 'Q') > @card1).to eq true
    end

    it 'returns -1 for when first card is smaller' do
      expect(Card.new('club', '9') < @card1).to eq true
    end
  end
end