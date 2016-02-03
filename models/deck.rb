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
        @cards.push(Card.new(color, value).card)
      end
    end
    @cards
  end

  def shuffle
    @cards.shuffle!
  end

  def draw
    shuffle

    (0..2).each do |n|
      start = n + 16
      @hands.push(Hand.new(@cards[start, start + 16]))
      @talon = Talon.new(@cards.reverse[0, 4])

      {
        hands: @hands,
        talon: @talon
      }
    end
  end
end
