module BookKeeping
  VERSION = 2
end

class RomanNumeral
  class AdditiveRule
    def initialize(numeral, value)
      @numeral = numeral
      @value = value
    end

    def apply(numerals, number)
      while number >= @value
        numerals << @numeral
        number -= @value
      end

      number
    end
  end

  class SubtractiveRule
    def initialize(numerals, replacement)
      @numerals = numerals
      @replacement = replacement
    end

    def apply(additive_numerals)
      additive_numerals.gsub! @numerals, @replacement
    end
  end

  ADDITIVE_RULES = [
    AdditiveRule.new("M", 1000),
    AdditiveRule.new("D", 500),
    AdditiveRule.new("C", 100),
    AdditiveRule.new("L", 50),
    AdditiveRule.new("X", 10),
    AdditiveRule.new("V", 5),
    AdditiveRule.new("I", 1)
  ].freeze

  SUBTRACTIVE_RULES = [
    SubtractiveRule.new("DCCCC", "CM"),
    SubtractiveRule.new("CCCC", "CD"),
    SubtractiveRule.new("LXXXX", "XC"),
    SubtractiveRule.new("XXXX", "XL"),
    SubtractiveRule.new("VIIII", "IX"),
    SubtractiveRule.new("IIII", "IV")
  ].freeze

  def initialize(number)
    @number = number
  end

  def to_i
    @number
  end

  def to_s
    result = apply_additive_rules(to_i)
    apply_subtractive_rules(result)
  end

  private

  def apply_additive_rules(value)
    "".tap do |result|
      ADDITIVE_RULES.each do |rule|
        value = rule.apply(result, value)
      end
    end
  end

  def apply_subtractive_rules(numerals)
    numerals.tap do |result|
      SUBTRACTIVE_RULES.each do |rule|
        rule.apply(result)
      end
    end
  end
end

class Integer
  def to_roman
    RomanNumeral.new(self).to_s
  end
end
