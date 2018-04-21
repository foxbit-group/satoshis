# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

class Satoshis
  VERSION = "0.1.0"

  PRECISION = 8
  ONE       = 100_000_000

  attr_reader :value

  def initialize(value)
    @value = \
      if value.is_a?(Integer)
        value
      elsif value.is_a?(BigDecimal)
        (value * ONE).to_i
      elsif value.is_a?(String)
        initialize(value.to_d)
      else
        raise(ArgumentError, "The argument 'value' must be Integer, BigDecimal or String.")
      end
  end

  def +(addend)
    sum = value + addend.value
    Satoshis.new(sum)
  end

  def -(subtrahend)
    difference = value - subtrahend.value
    Satoshis.new(difference)
  end

  def string
    result = value.abs.to_s

    result = \
      if result.length > PRECISION
        result.insert(-(PRECISION + 1), ".")
      else
        "0.#{result.rjust(PRECISION, "0")}"
      end

    result = "-#{result}" if negative?

    result
  end

  def string_formatted
    result = string.gsub(/0+$/, "")

    result = "#{result}0" if result.end_with?(".")

    result
  end

  alias to_s string_formatted

  def to_d
    string.to_d
  end

  private

  def negative?
    value < 0
  end
end
