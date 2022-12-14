require_relative 'board'
require_relative 'player'

class Game
  private

  attr_accessor :player1, :player2, :board

  public

  def initialize
    self.player1 = Player.new
    self.player2 = Player.new

    self.board = Board.new
  end

  def start
    current_player = player1
    round = 1

    announce_game_start

    until board.winner?(current_player) || board.available_locations.empty?
      current_player = toggle_current_player(current_player) unless round == 1

      location = current_player.get_location(board.locations, board.available_locations)
      current_player.play(board, location)

      clear_terminal

      announce_new_round(round)

      round += 1
    end

    announce_game_over
    board.winner?(current_player) ? announce_winner(current_player.name) : announce_tie
  end

  private

  def announce_game_start
    puts_with_padding('=', 'NEW GAME INITIATED')

    board.display_board
    puts ''
  end

  def announce_new_round(round)
    puts_with_padding('*', "Round #{round}")

    board.display_board
    puts ''
  end

  def announce_game_over
    puts_with_padding('=', 'GAME OVER')
  end

  def announce_winner(winner_name)
    puts_with_padding('=', "#{winner_name} won!!!")
  end

  def announce_tie
    puts_with_padding('=', 'It\'s a tie')
  end

  def clear_terminal
    system('cls') || system('clear')
  end

  def puts_with_padding(decorator_symbol, msg)
    10.times { print " #{decorator_symbol} " }
    print msg
    10.times { print " #{decorator_symbol} " }

    puts ''
  end

  def toggle_current_player(current_player)
    current_player == player1 ? player2 : player1
  end
end

game = Game.new

game.start
