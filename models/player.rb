class Player
  attr_accessor :hand

  def initialize(hand)
    @hand = hand
  end

  def choose_trump_card
    @hand.divide_into_colors
    posle tursim color.length
    i ako ima nai golqm toi e koz
    ako ne tursim silni karti ili neshto takova
  end
end