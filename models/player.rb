class Player

  COLORS = %w{heart spade club diamond}

  attr_accessor :hand, :trump, :min_wins, :current_wins

  def initialize(hand)
    @hand = hand
    @trump = @hand.cards.first.color
    @min_wins, @current_wins = 0, 0
  end

  def choose_trump_color
    @hand.grouped_cards.each do |color, cards|
      if cards.length > @hand.grouped_cards[@trump].length
        @trump = color
      end
    end
  end

  def draw_card(drawed_cards)
    p1_card = drawed_cards[0] ? drawed_cards[0] : nil
    p2_card = drawed_cards[1] ? drawed_cards[1] : nil

    if p1_card and p2_card
      chosen_card = choose_card(p1_card, p2_card)
    elsif p1_card
      chosen_card = choose_card(p1_card)
    else
      chosen_card = my_max_card(@hand.grouped_cards.first.first)
    end

    @hand.drop_chosen_card(chosen_card)
    chosen_card
  end

  def choose_card(p1_card, p2_card = nil)
    max_card = p2_card ? compare_cards(p1_card, p2_card) : p1_card

    if @hand.grouped_cards[p1_card.color]
      if max_card.color == p1_card.color
        return my_max_card(p1_card.color) > max_card ? my_max_card(p1_card.color) : my_min_card(p1_card.color)
      else
        return my_min_card(p1_card.color)
      end
    elsif @hand.grouped_cards[@trump]
      if max_card.color == @trump
        return my_max_card(@trump) > max_card ? my_max_card(@trump) : my_min_card(@trump)
      else
        return my_min_card(@trump)
      end
    else
      return my_min_card(@hand.grouped_cards.first.first)
    end
  end

  def my_max_card(color)
    @hand.arrange_cards
    @hand.grouped_cards[color].last
  end

  def my_min_card(color)
    @hand.arrange_cards
    @hand.grouped_cards[color].first
  end

  def compare_cards(p1_card, p2_card)
    if p1_card.color == p2_card.color
      return p1_card > p2_card ? p1_card : p2_card
    elsif p1_card.color == @trump
      return p1_card
    elsif p2_card.color == @trump
      return p2_card
    else
      return p1_card
    end
  end
end