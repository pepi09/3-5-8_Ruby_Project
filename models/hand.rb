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

  def divide_into_colors(cards_dropped = false)
    if @grouped_cards.empty? or cards_dropped
      @grouped_cards.clear if cards_dropped

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
    divide_into_colors(true)
  end

  def arrange_cards
    divide_into_colors if @grouped_cards.empty?

    @grouped_cards.each do |color, cards|
      cards.sort!
    end
  end

  def drop_chosen_card(card)
    @cards.delete(card)
    divide_into_colors(true)
  end

  def find_card(card)
    chosen_card = nil
    @cards.each do |card_in_hand|
      if card_in_hand == card
        chosen_card = card_in_hand
      end

    end
    chosen_card
  end
end
