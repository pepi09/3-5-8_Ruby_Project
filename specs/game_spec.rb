require_relative 'spec_helper.rb'

describe Game do

  before(:each) do
    @game = Game.new
    @game.draw
  end

  it 'draws cards to players' do
    expect(@game.players.length).to eq 3
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

end