class Card
    def initialize(color, value)
        @color = color
        @value = value
    end

    def getCard
        return {@color => @value}
    end

    def printCard
        return "%s "% @value + "of" + " %s" % @color
    end
end
