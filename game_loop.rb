# require '/models/'
load 'models/card.rb'
load 'models/deck.rb'
load 'models/hand.rb'
load 'models/player.rb'
load 'models/human_player.rb'
load 'models/game.rb'

# until(gets.chomp == 'exit')
  # names = []
  # (0...3).each do |index|
  #   p "Set player names"
def play_game
  game = Game.new
  game.draw
  game.players[0] = HumanPlayer.new(game.players[0].hand)
  game.set_min_wins(1)

  trump = game.players.first.choose_trump_color
  game.set_trump(trump)

  cards_for_talon = game.players.first.choose_cards_for_talon
  game.players.first.set_talon(game.talon, cards_for_talon)
  winner = 0

  p "Cards in talon are #{game.talon.cards.map(&:card)}"
  until game.players.first.hand.cards == []
    drawed_cards, players_cards = [], {}

    game.player_on_turn(winner).each do |index|
      drawed_cards.push(game.players[index - 1].draw_card(drawed_cards.clone))
      players_cards[index - 1] = drawed_cards.last
    end

    p "Drawwed_cards: #{drawed_cards.map(&:card)}"
    winner_card_index = game.choose_winning_card(drawed_cards)

    winner = players_cards.key(drawed_cards[winner_card_index])
    p "Player #{winner} wins this hand. \n"
    game.players[winner].current_wins += 1
    game.player_on_turn(winner)
  end

  # game.calculate_winns
  p "Result:"
  game.players.each do |player|
    p "Min wins: #{player.min_wins}"
    p "Current wins: #{player.current_wins}"
  end
end

play_game