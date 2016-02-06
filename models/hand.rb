class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def divide_into_colors
    groups_of_colors = {}
    @cards.each do |card|
      groups_of_colors[card.color] ||= []
      groups_of_colors[card.color].push card
    end
    groups_of_colors
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
end
