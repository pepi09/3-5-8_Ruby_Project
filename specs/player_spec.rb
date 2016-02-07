describe Player do

  before(:all) do
    @deck = [
      Card.new("heart", "K"),
      Card.new("diamond", "Q"),
      Card.new("spade", "A"),
      Card.new("club", "K")
    ]
    @player = Player.new(Hand.new(@deck))
  end

  context 'chooses trump card' do

    context 'when all colors are with equal length' do

      it 'selects first card\'s color by default' do
        @player.choose_trump_color

        expect(@player.trump).to eq @player.hand.cards.first.color
      end
    end

    context 'when some color has more cards' do

      it 'selects color with largest number of cards in hand' do
        deck = [
          Card.new("diamond", "K"),
          Card.new("spade", "A"),
          Card.new("diamond", "Q"),
          Card.new("club", "K")
        ]
        player = Player.new(Hand.new(deck))

        player.choose_trump_color

        expect(player.trump).to eq 'diamond'
      end
    end
  end
end