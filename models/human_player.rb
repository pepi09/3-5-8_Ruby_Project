class HumanPlayer
  attr_accessor :hand, :trump, :min_wins, :current_wins

  def initialize(hand)
    @hand = hand
    @trump = @hand.cards.first.color
  end

  def choose_trump_color
    print_current_hand
    p 'Choose trump color'
    trump = gets.chomp
    @trump = trump
  end

  def draw_card
    print_current_hand
    p 'Draw card'
    card = pick_card(gets.chomp)
    @hand.drop_chosen_card(card)
    card
  end

  def print_current_hand
    p 'Your cards are:'
    p @hand.grouped_cards
    # @hand.print_hand
  end
end