class SecretWord
  def initialize
    @secret_word = get_word_from_dict '5desk.txt'
  end

  def assess(guess)
    @secret_word.each_char.map { |c| c == guess }
  end

  def reveal
    puts "The secret word is #{@secret_word}"
    initialize
  end

  private

  def get_word_from_dict(dict_path, min_len: 5, max_len: 12)
    dict = File.open(dict_path, chomp: true)
    words = dict.readlines
    word = ''
    word = words.sample until word.length.between?(min_len, max_len)
    word.upcase
  end
end
