require_relative 'spec_helper.rb'

describe Deck do
  it 'generates all cards' do
    expect(Deck.new.cards.length).to eq 52
  end

  it 'shuffles cards' do
    deck = Deck.new
    unshuffled_deck = deck.cards.clone

    deck.shuffle

    expect(deck.cards).to_not eq unshuffled_deck
  end

  it 'shuffles deck every time differently' do
    deck1, deck2 = Deck.new, Deck.new

    expect(deck1).to eq deck2

    deck1.shuffle
    deck2.shuffle

    expect(deck1).to_not eq deck2
  end

  it 'draws players hands' do
    hands = Deck.new.draw[:hands]
    hands.each do |hand|
      expect(hand.cards.length).to eq 16
    end
  end

  it 'creates talon' do
    expect(Deck.new.draw[:talon].cards.length).to eq 4
  end
end