require_relative 'spec_helper.rb'

describe Hand do
  before(:all) do
    @deck = [
      Card.new("heart", "K"),
      Card.new("heart", "Q"),
      Card.new("spade", "A"),
      Card.new("club", "K")
    ]
    @hand = Hand.new(@deck)
  end

  it 'divides cards into colors' do
    grouped_cards = {heart: [@deck[0], @deck[1]], spade: [@deck[2]]}

    expect(@hand.grouped_cards['heart']).to eq grouped_cards[:heart]
    expect(@hand.grouped_cards['spade']).to eq grouped_cards[:spade]
  end

  it 'applies_talon' do
    cards_in_talon = [
      Card.new("diamond", '3'),
      Card.new("diamond", "6"),
      Card.new("diamond", "10"),
      Card.new("diamond", "J")
    ]
    hand = Hand.new(@deck.clone)
    talon = Talon.new(cards_in_talon)

    hand.apply_talon(talon, @deck.clone)

    expect(hand.cards).to eq cards_in_talon
  end

  it 'arranges cards in hand' do
    @hand.arrange_cards

    expect(@hand.grouped_cards['heart'].first.value).to eq 'Q'
  end

  it 'drops chosen card' do
    hand = Hand.new(@deck.clone)
    hand.drop_chosen_card(@deck[0])

    expect(hand.cards).to_not include @deck[0]
  end

  context 'finds card in hand' do
    it 'returns found card' do
      expect(@hand.find_card(@deck[2])).to eq @deck[2]
    end

    it 'raises error when card is not in hand' do
      card = Card.new('club', '2')
      expect{
        @hand.find_card(card)
        }.to raise_error("Card #{card.card} not in hand")
    end
  end
end