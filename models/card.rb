class Card
  attr_reader :card, :color, :value

  def initialize(color, value)
    @color = color
    @value = value
    @card = { @color.to_sym => @value }
  end

  def print
    "#{@value} of #{pluralize(@color)}"
  end

  private

  def pluralize(singular)
    "#{singular}s"
  end
end

