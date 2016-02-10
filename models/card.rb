class Card
  attr_reader :card, :color, :value

  def initialize(color, value)
    @color = color
    @value = value.to_s
    @card = { @color.to_sym => @value }
  end

  def humanize
    "#{@value} of #{pluralize(@color)}"
  end

  def <=>(other)
    return unless @color == other.color

    arranged_values = (2..10).to_a.map(&:to_s).push('J', 'Q', 'K', 'A')

    arranged_values.index(@value) <=> arranged_values.index(other.value)
  end

  def <(other)
    self.<=>(other) == -1
  end

  def >(other)
    self.<=>(other) == 1
  end

  def ==(other)
    self.<=>(other) == 0
  end

  private

  def pluralize(singular)
    "#{singular}s"
  end
end

