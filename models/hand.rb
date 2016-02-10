class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
    @grouped_cards = {}
  end

  def grouped_cards
    divide_into_colors if @grouped_cards.empty?
    @grouped_cards
  end

  def divide_into_colors
    if @grouped_cards.empty?
      @cards.each do |card|
        @grouped_cards[card.color] ||= []
        @grouped_cards[card.color].push card
      end
    end
    @grouped_cards
  end

  def apply_talon(talon, cards_to_replace)
    cards_to_replace.each do |card|
      @cards.delete(card)
    end
    @cards.concat(talon.cards)
  end

  def print_hand
    @grouped_cards.each do |color, cards|
      p color
      cards.each do |card|
        puts card.value
      end
    end
  end

  def arrange_cards
    divide_into_colors if @grouped_cards.empty?

    @grouped_cards.each do |color, cards|
      cards.sort!
    end
  end

  def drop_chosen_card(card)
    @cards.delete(card)
    divide_into_colors
    arrange_cards
  end

  def find_card(card)
    @cards.each do |card_in_hand|
      if card_in_hand == card
        return card_in_hand
      end
    end
  end
end
