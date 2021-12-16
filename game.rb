require './secret_word'
require './error_counter'
require './guessed_word'

class Game
  def initialize(savefilename)
    @SAVEFILENAME = savefilename
    @secret_word = SecretWord.new
    @error_counter = ErrorCounter.new
    @guessed_word = GuessedWord.new(@secret_word.length)
  end

  def run
    puts 'You can type \'SAVE\' to save your game'
    loop do
      display_status
      read_guess
      if @input == 'SAVE'
        save_game
        break
      end
      assess_guess
      

      break if finished?
    end
  end

  private

  def read_guess
    puts 'Guess a letter'
    @input = gets.chomp.upcase
    @guess = @input.chr
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

  def save_game
    save = File.new @SAVEFILENAME, 'w'
    save.puts Marshal.dump(self)
    save.close
  end
end
