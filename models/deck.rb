require_relative  "card"
require_relative  "talon"
require_relative  "hand"

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    colors = %w{heart spade diomond club}
    values = (2..10).to_a.push('J', 'Q', 'K', 'A')

    colors.each do |color|
      values.each do |value|
        @cards.push(Card.new(color, value))
      end
    end
  end

  def shuffle
    @cards.shuffle!
    return
  end

  def draw
    hands, talon = [], []
    shuffle

    (0..2).each do |n|
      start = n == 0 ? 0 : n * 16
      hands.push(Hand.new(@cards[start, 16]))
    end

    talon = Talon.new(@cards.reverse[0, 4])

    {
      hands: hands,
      talon: talon
    }
  end

  def humanize_cards
    humanized_cards = []
    @cards.each do |card|
      humanized_cards.push card.humanize
    end
    humanized_cards
  end

  def ==(other)
    (0...52).each do |index|
      unless @cards[index].card == other.cards[index].card
        return false
      end
    end
  end
end
