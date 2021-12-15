class ErrorCounter
  def initialize
    @i = 0
  end

  def display
    puts "#{@i} errors made."
  end

  def increase(assessment)
    @i += 1 if assessment.all?(false)
  end

  def defeat?
    @i >= 10
  end
end
