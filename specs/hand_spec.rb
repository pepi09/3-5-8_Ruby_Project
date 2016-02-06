require_relative 'spec_helper.rb'

describe Hand do
  before(:all) do
    @card1 = Card.new("heart", "Q")
    @card2 = Card.new("heart", "K")
    @card3 = Card.new("spade", "A")
    @card4 = Card.new("diamond", "K")
    @hand = Hand.new([@card1, @card2, @card3, @card4])
  end

  it 'divides cards into colors' do
    grouped_cards = {heart: [@card1, @card2], spade: [@card3]}

    expect(@hand.divide_into_colors['heart']).to eq grouped_cards[:heart]
    expect(@hand.divide_into_colors['spade']).to eq grouped_cards[:spade]
  end

  it 'applies_talon' do
    cards_in_talon = [
      card1 = Card.new("diamond", '3'),
      card2 = Card.new("diamond", "6"),
      card3 = Card.new("diamond", "10"),
      card4 = Card.new("diamond", "J")
    ]
    hand = Hand.new([@card1, @card2, @card3, @card4])
    talon = Talon.new(cards_in_talon)

    hand.apply_talon(talon, [@card1, @card2, @card3, @card4])

    expect(hand.cards).to eq cards_in_talon
  end
end