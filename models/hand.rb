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
    divide_into_colors.each do |color, cards|
      p color
      cards.each do |card|
        puts card.card
      end
    end
    return
  end

  def arrange_cards
    @grouped_cards.each do |color, cards|
      cards.sort!
    end
  end
end
