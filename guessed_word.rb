class GuessedWord 
  def initialize
    @val = ''
  end

  def improve(char, assessment)
    @val = '_' * assessment.length if @val == ''
    @val = @val.each_char.zip(assessment).map { |v, a| a ? char : v }.join
  end

  def display
    puts @val.split('').join ' '
  end

  def correct?
    @val.each_char.none? '_'
  end
end
