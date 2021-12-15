require './secret_word'
require './error_counter'
require './guessed_word'

class Game
  def initialize
    @secret_word = SecretWord.new
    @error_counter = ErrorCounter.new
    @guessed_word = GuessedWord.new
  end

  def run
    loop do
      read_guess
      assess_guess
      display_status

      break if finished?
    end
  end

  private

  def read_guess
    puts 'Guess a letter'
    @guess = gets.chr.upcase
  end

  def assess_guess
    assessment = @secret_word.assess(@guess)
    @guessed_word.improve @guess, assessment
    @error_counter.increase assessment
  end

  def display_status
    @error_counter.display
    @guessed_word.display
  end

  def finished?
    if @guessed_word.correct?
      puts 'You won!'
      true
    elsif @error_counter.defeat?
      puts 'You were hanged...'
      @secret_word.reveal
      true
    else
      false
    end
  end
end

game = Game.new
game.run
