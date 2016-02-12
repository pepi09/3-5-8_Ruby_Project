require_relative 'spec_helper.rb'

describe Game do

  before(:each) do
    @game = Game.new
    @game.draw

    @game.set_trump('spade')
  end

  it 'draws cards to players' do
    expect(@game.players.length).to eq 3
  end

  context 'set trump color' do

    it 'sets trump color for game' do
      @game.set_trump('club')

      expect(@game.trump).to eq 'club'
    end

    it 'sets trump for all players' do
      @game.set_trump('diamond')

      expect(@game.players.map(&:trump).uniq).to eq ['diamond']
    end
  end

  context 'set minimum wins' do

    it 'sets sequence starting from the first player' do
      @game.set_min_wins(1)
      sequence = [8, 5, 3]

      expect(@game.players.map(&:min_wins)).to eq sequence
    end

    it 'sets equence starting from the second player' do
      @game.set_min_wins(2)
      sequence = [3, 8, 5]

      expect(@game.players.map(&:min_wins)).to eq sequence
    end

    it 'sets equence starting from the third player' do
      @game.set_min_wins(3)
      sequence = [5, 3, 8]

      expect(@game.players.map(&:min_wins)).to eq sequence
    end
  end

  context 'choose winning card' do

    before(:all) do
      @cards = [
        Card.new('heart', '5'),
        Card.new('heart', 'A'),
        Card.new('diamond', '7'),
        Card.new('club', 'K'),
        Card.new('spade', 'K'),
      ]
    end

    context 'all cards are from the same color' do

      it 'chooses the maximum card for winner' do
        expect(@game.choose_winning_card(@cards[0..2])).to eq 1
      end
    end

    context 'first two cards have the same color' do

      context 'third card is not trump card' do

        it 'chooses the maximum between the first two cards' do
          @game.set_trump('spade')

          expect(@game.choose_winning_card(@cards[1..3])).to eq 0
        end
      end

      context 'third card is trump card' do

        it 'chooses the third card' do
          drawed_cards = @cards[0..1].push(@cards[4])

          expect(@game.choose_winning_card(drawed_cards)).to eq 2
        end
      end
    end

    context 'second card is trump card but first isn\'t' do

      context 'third card is also trump card' do

        it 'chooses between the second and the third card' do
          drawed_cards = @cards[0..1].push(@cards[4])

          expect(@game.choose_winning_card(drawed_cards)).to eq 2
        end
      end

      context 'only second card is trump card' do

        it 'chooses the second card' do
          drawed_cards = [@cards[0], @cards[4], @cards[3]]

          expect(@game.choose_winning_card(drawed_cards)).to eq 1
        end
      end
    end

    context 'first and third card have the same color' do

      context 'second card is not trump color' do

        it 'chooses between first and third card' do
          drawed_cards = [@cards[0], @cards[3], @cards[1]]

          expect(@game.choose_winning_card(drawed_cards)).to eq 2
        end
      end
    end

    context 'second and third card are the came color but not trump' do

      context 'first card is trump' do

        it 'chooses the first card' do
          drawed_cards = [@cards[4], @cards[0], @cards[1]]

          expect(@game.choose_winning_card(drawed_cards)).to eq 0
        end
      end
    end

    context 'all cards are different colors and none of them is trump color' do

      it 'chooses the first card' do
        drawed_cards = [@cards[1], @cards[2], @cards[3]]

        expect(@game.choose_winning_card(drawed_cards)).to eq 0
      end
    end
  end
end