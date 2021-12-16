require './game'

class Hangman
  def initialize
    @SAVEFILENAME = 'save'
  end

  def run
    puts 'Welcome to the game of Hangman.'
    options = %w[1 2]
    choice = ''
    loop do
      puts '1) New Game'
      puts '2) Load Game'
      choice = gets.chomp

      break if options.include? choice
    end

    case choice
    when '1'
      play_new_game
    when '2'
      load_game
    end
  end

  private

  def play_new_game
    game = Game.new(@SAVEFILENAME)
    game.run
  end

  def load_game
    if File.exists? @SAVEFILENAME
      save = File.open @SAVEFILENAME
      game_str = save.gets.chomp
      game =  Marshal.load(game_str)
      save.close
      game.run
    else
      puts 'ERROR: no save file found.'
    end
  end
end

hangman = Hangman.new
hangman.run