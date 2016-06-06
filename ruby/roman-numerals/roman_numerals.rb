module BookKeeping
  VERSION = 2
end

class RomanDigit
  attr_reader :numeral, :value

  def initialize(numeral, value, prefix = nil)
    @numeral = numeral
    @value = value
    @prefix = prefix
  end

  def prefix_value
    if @prefix
      @prefix.value
    else
      0
    end
  end

  def prefixed_numeral
    "#{@prefix.numeral}#{numeral}"
  end

  def prefixed_value
    value - prefix_value
  end

  def applicable?(number)
    number >= prefixed_value
  end

  def apply(numerals, number)
    if number >= value
      numerals << numeral
      number - value
    elsif number >= prefixed_value
      numerals << prefixed_numeral
      number - prefixed_value
    end
  end
end

class RomanNumeral
  I = RomanDigit.new("I", 1)
  V = RomanDigit.new("V", 5, I)
  X = RomanDigit.new("X", 10, I)
  L = RomanDigit.new("L", 50, X)
  C = RomanDigit.new("C", 100, X)
  D = RomanDigit.new("D", 500, C)
  M = RomanDigit.new("M", 1000, C)
  DIGITS = [M, D, C, L, X, V, I].freeze

  def initialize(number)
    @number = number
  end

  def to_i
    @number
  end

  def to_s
    numerals = ""
    value = to_i

    DIGITS.each do |digit|
      value = digit.apply(numerals, value) while digit.applicable?(value)
    end

    numerals
  end
end

class Integer
  def to_roman
    RomanNumeral.new(self).to_s
  end
end
