# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"
require "forwardable"

class Satoshis
  extend Forwardable

  VERSION = "0.2.0"

  PRECISION = 8
  ONE       = 100_000_000

  attr_reader :value

  def_delegators :value, :to_i

  def initialize(value)
    raise(ArgumentError, "Value can't be nil.") if value.nil?

    @value = Satoshis.ensure_integer(value)
  end

  def self.ensure_integer(value)
    if value.is_a?(Integer)
      value
    elsif value.is_a?(BigDecimal)
      (value * ONE).to_i
    elsif value.is_a?(String)
      (value.to_d * ONE).to_i
    else
      raise(ArgumentError, "Value must be Integer, BigDecimal or String.")
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

  def formatted(short: true)
    result = string

    if short
      result = result.gsub(/0+$/, "")
      result = "#{result}0" if result.end_with?(".")
    end

    result
  end

  alias to_s formatted

  def to_d
    formatted.to_d
  end

  def positive?
    value > 0
  end

  def negative?
    value < 0
  end

  private

  def string
    result = value.abs.to_s

    result = \
      if result.length > PRECISION
        result.insert(-(PRECISION + 1), ".")
      else
        "0.#{result.rjust(PRECISION, "0")}"
      end

    negative? ? "-#{result}" : result
  end
end
