class HumanPlayer < Player
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

    until trump and COLORS.include? trump
      p 'Choose trump color from: spade, heart, club, diamond'
      trump = gets.chomp
    end

    @trump = trump
  end

  def draw_card(drawed_cards)
    p "Your oponents drawed #{drawed_cards.map(&:card)}"
    print_current_hand

    p 'Draw card'
    card = read_user_card

    until card and @hand.cards.include? card
      p 'Card not in hand! Draw again!'
      card = read_user_card
      p card
    end
    p "out #{card}"
    @hand.drop_chosen_card(card)
    card
  end

  def choose_cards_for_talon
    p 'Choose which cards to replace with cards in talon.'

    cards_for_talon = []

    (0..3).each do
      p 'Choose card.'
      card = read_user_card

      until card and @hand.cards.include? card
        p 'Card not in hand! Choose again!'
        card = read_user_card
      end

      cards_for_talon.push(card)
    end

    cards_for_talon
  end

  def read_user_card
    card = gets.chomp
    card = card.split(' ')
    card = pick_card(card)
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
  end
end