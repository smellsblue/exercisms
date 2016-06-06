module BookKeeping
  VERSION = 2
end

class RomanNumerizer
  attr_reader :numerals

  def initialize(value)
    @value = value
    @numerals = ""
  end

  def romanize(value, numeral, prefix_value, prefix_numeral)
    while @value >= value
      @numerals << numeral
      @value -= value
    end

    if @value >= value - prefix_value
      @numerals << prefix_numeral
      @numerals << numeral
      @value -= value - prefix_value
    end
  end

  def romanize_remaining
    @numerals << "I" * @value
    @value = 0
  end
end

class RomanNumeral
  def initialize(number)
    @number = number
  end

  def to_i
    @number
  end

  def to_s
    result = RomanNumerizer.new(to_i)
    result.romanize 1000, "M", 100, "C"
    result.romanize 500, "D", 100, "C"
    result.romanize 100, "C", 10, "X"
    result.romanize 50, "L", 10, "X"
    result.romanize 10, "X", 1, "I"
    result.romanize 5, "V", 1, "I"
    result.romanize_remaining
    result.numerals
  end
end

class Integer
  def to_roman
    RomanNumeral.new(self).to_s
  end
end
