describe Deck do
  it 'generates all cards' do
    expect(Deck.new.cards.length).to eq 52
  end

  it 'shuffles cards' do
    deck1, deck2 = Deck.new, Deck.new

    expect(deck1.cards).to eq deck2.cards
    expect(deck1.shuffle).to_not eq deck2.shuffle
  end

  it 'draws players hands' do
    hands = Deck.new.draw.hand
    hands.each do |hand|
      expect(hand.length).eq 16
    end
  end

  it 'creates talon' do
    expect(Deck.new.draw.talon.length).to eq 4
  end
end