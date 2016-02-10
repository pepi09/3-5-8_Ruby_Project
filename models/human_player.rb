class HumanPlayer
  attr_accessor :hand, :trump, :min_wins, :current_wins

  def initialize(hand)
    @hand = hand
    @trump = @hand.cards.first.color
    @min_wins, @current_wins = 0, 0
  end

  def choose_trump_color
    print_current_hand
    p 'Choose trump color'
    trump = gets.chomp
    @trump = trump
  end

  def draw_card(drawed_cards)
    p "Your oponents drawed #{drawed_cards.map(&:card)}"
    print_current_hand
    p 'Draw card'
    card = gets.chomp
    card = card.split(' ')
    card = pick_card(card)
    @hand.drop_chosen_card(card)
    card
  end

  def pick_card(card)
    @hand.find_card(Card.new(card[0], card[1]))
  end

  def print_current_hand
    p 'Your cards are:'
    @hand.arrange_cards
    @hand.grouped_cards.each do |color, group|
      cards = "#{color}:"
      group.each {|card| cards << " #{card.value},"}
      p cards
    end
    # @hand.print_hand
  end
end