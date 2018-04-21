# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

class Satoshis
  VERSION = "0.1.0"

  PRECISION = 8
  ONE       = 100_000_000

  attr_reader :value

  def initialize(value)
    @value = value
  end

  class << self
    def from_integer(value)
      raise(ArgumentError, "value must be an Integer") unless value.is_a? Integer

      new(value)
    end

    def from_big_decimal(bitcoins)
      raise(ArgumentError, "bitcoins must be a BigDecimal") unless bitcoins.is_a? BigDecimal

      new((bitcoins * ONE).to_i)
    end

    def from_string(bitcoins)
      raise(ArgumentError, "bitcoins must be a String") unless bitcoins.is_a? String

      Satoshis.from_big_decimal(bitcoins.to_d)
    end
  end

  def +(addend)
    sum = value + addend.value
    Satoshis.new(sum)
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
