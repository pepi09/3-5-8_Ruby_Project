class Game
  attr_accessor :trump, :players

  def initialize
    @players = []
    @trump
  end

  def draw
    deck = Deck.new.draw
    hands = deck[:hands]
    talon = deck[:talon]

    hands.each do |hand|
      @players.push(Player.new(hand))
    end
  end

  def set_min_wins(number_of_first_player)
    @players.each_index do |index|
      @players[index].min_wins = set_sequence(number_of_first_player)[index]
    end
  end

  def choose_winning_card(drawed_cards)
    winner = 0
    drawed_cards.each_slice(3) do |card_1, card_2, card_3|
      if card_1.color == card_2.color and card_2.color == card_3.color
        winner = drawed_cards.max {|a, b| a <=> b}
      elsif card_1.color == card_2.color and card_3.color != @trump
        winner = drawed_cards[0, 2].max {|a, b| a <=> b}
      elsif card_1.color == card_2.color and card_1.color != @trump and card_3.color == @trump
        winner = card_3
      elsif card_2.color == @trump and card_1.color != @trump
        if card_3.color == @trump
          winner = drawed_cards[1, 2].max {|a, b| a <=> b}
        else
          winner = card_2
        end
      elsif card_1.color == card_3.color and card_2.color != @trump
        winner = [card_1, card_3].max {|a, b| a <=> b}
      elsif card_3.color == card_2.color and card_2.color != @trump and card_1.color == @trump
        winner = card_1
      end
    end

    drawed_cards.index(winner)
  end

  def player_on_turn(index)
    case index + 1
    when 1
      return [1, 2, 3]
    when 2
      return [2, 3, 1]
    when 3
      return [3, 1, 2]
    end
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

  def set_trump(trump)
    @players.each do |player|
      player.trump = trump
    end
  end
end