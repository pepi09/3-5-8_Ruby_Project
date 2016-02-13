load 'models/card.rb'
load 'models/deck.rb'
load 'models/hand.rb'
load 'models/player.rb'
load 'models/human_player.rb'
load 'models/game.rb'

class GameLoop
  def set_up_game
    @game = Game.new
  end

  def play_game(continue = false, first_player = 1)
    @game.draw(continue)
    @game.players[0] = HumanPlayer.new(@game.players[0].hand) unless continue
    @game.set_min_wins(first_player)

    trump = @game.players[first_player - 1].choose_trump_color
    @game.set_trump(trump)
    p "Trump is: '#{trump}'"

    cards_for_talon = @game.players[first_player - 1].choose_cards_for_talon
    @game.players[first_player - 1].set_talon(@game.talon, cards_for_talon)

    winner = first_player - 1

    p "Cards in talon are #{@game.talon.cards.map(&:card)}"

    until @game.players[winner].hand.cards.empty?
      drawed_cards, players_cards = [], {}

      @game.player_on_turn(winner).each do |index|
        drawed_cards.push(@game.players[index - 1].draw_card(drawed_cards.clone))
        players_cards[index - 1] = drawed_cards.last
      end

      p "Drawed_cards: #{drawed_cards.map(&:card)}"
      winner_card_index = @game.choose_winning_card(drawed_cards)

      winner = players_cards.key(drawed_cards[winner_card_index])
      p "Player #{winner} wins this hand."
      @game.players[winner].current_wins += 1
      @game.player_on_turn(winner)
    end

    print_result
  end

  def game_loop
    set_up_game
    play_game

    [2,3].each do |index|
      play_game(true, index)
    end

    puts "\n"
    p "Game Over!"
    print_result
  end

  def print_result
    puts "\n"
    p "Result:"
    @game.players.each do |player|
      player.calculate_result
      puts "\n"
      p "Player #{@game.players.index(player)}"
      p "Min wins:     #{player.min_wins}"
      p "Current wins: #{player.current_wins}"
      p "Result:       #{player.result}"
    end
  end
end

GameLoop.new.game_loop()