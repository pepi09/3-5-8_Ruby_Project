class Game
  attr_accessor :trump, :players

  # def initialize
  #   @players
  #   @trump
  # end

  def draw
    hands, talon = Deck.new.draw

    hands.each do |hand|
      @players.push(Player.new(hand))
    end
  end

  def set_min_wins(number_of_player)
    @players.each_index do |index|
      @players[index].min_wins = set_sequence[index]
    end
  end

  def choose_winning_card(drawed_cards)
    max = drawed_cards.max
    drawed_cards.index(max)
  end

  def player_on_turn(index)

  end

  def set_sequence(number)
    case number
    when 1
      [8, 5, 3]
    when 2
      [3, 8, 5]
    when 3
      [5, 3, 8]
    end
  end


end