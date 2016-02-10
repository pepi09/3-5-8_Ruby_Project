# require '/models/'
load 'models/card.rb'
load 'models/deck.rb'
load 'models/hand.rb'
load 'models/player.rb'
load 'models/human_player.rb'
load 'models/game.rb'

# until(gets.chomp == 'exit')
  game = Game.new
  game.draw
  game.players[0] = HumanPlayer.new(game.players[0].hand)
  game.set_min_wins(1)
  trump = game.players.first.choose_trump_color
  game.set_trump(trump)

  until game.players.first.hand.cards == []
    drawed_cards, winner = [], 1

    game.player_on_turn(winner).each do |index|
      drawed_cards.push(game.players[index - 1].draw_card(drawed_cards))
    end

    winning_card_index = game.choose_winning_card(drawed_cards)

    @players[winner].current_wins += 1
    game.player_on_turn(winner)
  end

  # game.calculate_winns
  p Result:
  game.players.each do |player|
    p "Min wins: #{player.min_wins}"
    p "Current wins: #{player.current_wins}"
  end
# end
