describe Player do

  before(:each) do
    @deck = [
      Card.new("heart", "K"),
      Card.new("heart", "6"),
      Card.new("diamond", "Q"),
      Card.new("diamond", "7"),
      Card.new("spade", "5"),
      Card.new("spade", "A"),
      Card.new("club", "K"),
      Card.new("club", "J")
    ]
    @player = Player.new(Hand.new(@deck))
  end



  context 'chooses trump color' do

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

  context 'compare cards' do

    context 'when cards have the same color' do

      it 'returns the bigger card' do
        expect(@player.compare_cards(@deck[0], @deck[1])).to eq @deck[0]
      end
    end

    context 'when colors of cards are different' do

      context 'when first card is from trump color' do

        it 'returns the first card' do
          @player.trump = 'heart'
          expect(@player.compare_cards(@deck[0], @deck[2])).to eq @deck[0]
        end
      end

      context 'when second card is from trump color' do

        it 'returns the second card' do
          @player.trump = 'heart'
          expect(@player.compare_cards(@deck[2], @deck[1])).to eq @deck[1]
        end
      end

      context 'when none of the cards is from trump color' do

        it 'returns the first card' do
          @player.trump = 'heart'
          expect(@player.compare_cards(@deck[3], @deck[4])).to eq @deck[3]
        end
      end
    end
  end

  context 'draws card' do

    context 'player draws first' do

      it 'draws max card from any color' do
        card_to_draw = {heart: 'K'}

        expect(@player.draw_card([]).card).to eq card_to_draw
      end
    end

    context 'player draws second' do

      context 'player has cards from the first player\'s color' do

        context 'player has bigger card than the first player' do

            it 'draws max card of the same color' do
              p1_card = Card.new('spade', 'Q')
              card_to_draw = {spade: 'A'}

              expect(@player.draw_card([p1_card]).card).to eq card_to_draw
            end
          end

          context 'player does not have bigger cards than the first player' do

            it 'draws min card of the same color' do
              p1_card = Card.new('club', 'A')
              card_to_draw = {club: 'J'}

              expect(@player.draw_card([p1_card]).card).to eq card_to_draw
            end
          end
      end

      context 'player does not have cards from the first player\'s color' do

        context 'player has trump cards'  do

          it 'draws min card of trump color' do
            @player.trump = 'club'
            @player.hand.cards.delete_if do |card|
              card.color == 'spade'
            end
            p1_card = Card.new('spade', 'Q')
            card_to_draw = {club: 'J'}

            expect(@player.draw_card([p1_card]).card).to eq card_to_draw
          end
        end

        context 'player does not have trump cards' do

          it 'draws min card from another color' do
            @player.trump = 'club'
            @player.hand.cards.delete_if do |card|
              card.color == 'spade' or card.color == 'club'
            end
            p1_card = Card.new('spade', 'Q')
            card_to_draw = {heart: '6'}

            expect(@player.draw_card([p1_card]).card).to eq card_to_draw
          end
        end
      end
    end

    context 'player draws third' do

      context 'player has cards from first player\'s card color' do

        context 'all players draw the same color' do

          context 'player has bigger card than others' do

            it 'draws max card of the same color' do
              p1_card = Card.new('spade', 'Q')
              p2_card = Card.new('spade', '4')
              card_to_draw = {spade: 'A'}

              expect(@player.draw_card([p1_card, p2_card]).card).to eq card_to_draw
            end
          end

          context 'player does not have bigger cards than others' do

            it 'draws min card of the same color' do
              p1_card = Card.new('club', '4')
              p2_card = Card.new('club', 'A')
              card_to_draw = {club: 'J'}

              expect(@player.draw_card([p1_card, p2_card]).card).to eq card_to_draw
            end
          end
        end

        context 'second player draws trump color' do

          it 'draws min card of the first player\'s color' do
            @player.trump = 'spade'
            p1_card = Card.new('club', '4')
            p2_card = Card.new('spade', '2')
            card_to_draw = {club: 'J'}

            expect(@player.draw_card([p1_card, p2_card]).card).to eq card_to_draw
          end
        end
      end

      context 'player does not have cards from first player\'s card color' do

        context 'player has trump color cards' do

          context 'second player also draws trump card' do

            context 'player has bigger trump card' do

              it 'draws max card of trump color' do
                @player.trump = 'club'
                @player.hand.cards.delete_if do |card|
                  card.color == 'spade'
                end
                p1_card = Card.new('spade', 'Q')
                p2_card = Card.new('club', '4')
                card_to_draw = {club: 'K'}

                expect(@player.draw_card([p1_card, p2_card]).card).to eq card_to_draw
              end
            end

            context 'player does not have bigger trump card' do

              it 'draws min card of trump color' do
                @player.trump = 'club'
                @player.hand.cards.delete_if do |card|
                  card.color == 'spade'
                end
                p1_card = Card.new('spade', 'Q')
                p2_card = Card.new('club', 'A')
                card_to_draw = {club: 'J'}

                expect(@player.draw_card([p1_card, p2_card]).card).to eq card_to_draw
              end
            end
          end

          context 'second player does not draw trump card' do

            it 'draws min card of trump color' do
              @player.trump = 'club'
              @player.hand.cards.delete_if do |card|
                card.color == 'spade'
              end
              p1_card = Card.new('spade', 'Q')
              p2_card = Card.new('diamond', 'A')
              card_to_draw = {club: 'J'}

              expect(@player.draw_card([p1_card, p2_card]).card).to eq card_to_draw
            end
          end
        end

        context 'player does not have trump cards' do

          it 'draws min card from another color' do
            @player.trump = 'club'
            @player.hand.cards.delete_if do |card|
              card.color == 'spade' or card.color == 'club'
            end
            p1_card = Card.new('spade', 'Q')
            p2_card = Card.new('diamond', 'A')
            card_to_draw = {heart: '6'}

            expect(@player.draw_card([p1_card, p2_card]).card).to eq card_to_draw
          end
        end
      end
    end

    it 'droppes drawed card from hand' do
      p1_card = Card.new('spade', 'Q')
      p2_card = Card.new('spade', '4')
      card_to_draw = @player.draw_card([p1_card, p2_card])

      expect(@player.hand.cards).to_not include card_to_draw
    end
  end
end