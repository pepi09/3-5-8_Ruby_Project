require_relative 'spec_helper.rb'

describe Hand do
  before(:all) do
    @deck = [
      Card.new("heart", "Q"),
      Card.new("heart", "K"),
      Card.new("spade", "A"),
      Card.new("club", "K")
    ]
    @hand = Hand.new(@deck)
  end

  it 'divides cards into colors' do
    grouped_cards = {heart: [@deck[0], @deck[1]], spade: [@deck[2]]}

    expect(@hand.divide_into_colors['heart']).to eq grouped_cards[:heart]
    expect(@hand.divide_into_colors['spade']).to eq grouped_cards[:spade]
  end

  it 'applies_talon' do
    cards_in_talon = [
      Card.new("diamond", '3'),
      Card.new("diamond", "6"),
      Card.new("diamond", "10"),
      Card.new("diamond", "J")
    ]
    hand = Hand.new(@deck)
    talon = Talon.new(cards_in_talon)

    hand.apply_talon(talon, @deck.clone)

    expect(hand.cards).to eq cards_in_talon
  end
end