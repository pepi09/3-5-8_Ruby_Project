class Card
  attr_reader :card, :color, :value

  def initialize(color, value)
    @color = color
    @value = value
    @card = { @color.to_sym => @value }
  end

  def humanize
    "#{@value} of #{pluralize(@color)}"
  end

  def <=>(other)
    return unless @color == other.color

    arranged_values = (2..10).to_a.push('J', 'Q', 'K', 'A')

    arranged_values.index(@value) <=> arranged_values.index(other.value)
  end

  private

  def pluralize(singular)
    "#{singular}s"
  end
end

