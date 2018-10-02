# frozen_string_literal: true

class CoinDecimal
  extend Forwardable

  BITCOIN_PRECISION = 8
  MAX_PRECISION     = 32

  attr_reader :value, :precision

  def_delegators :value, :to_i

  def initialize(value, precision = BITCOIN_PRECISION)
    raise(ArgumentError, "Precision must be an Integer.") unless precision.is_a?(Integer)

    raise(ArgumentError, "Precision must be less than or equal to #{MAX_PRECISION}.") if precision > MAX_PRECISION

    raise(ArgumentError, "Precision can't be negative.") if precision < 0

    @precision = precision

    raise(ArgumentError, "Value can't be nil.") if value.nil?

    @value = CoinDecimal.ensure_integer(value, precision)
  end

  def self.ensure_integer(value, precision = BITCOIN_PRECISION)
    if value.is_a?(Integer)
      value
    elsif value.is_a?(BigDecimal)
      (value * (10 ** precision)).to_i
    elsif value.is_a?(String)
      (value.to_d * (10 ** precision)).to_i
    else
      raise(ArgumentError, "Value must be Integer, BigDecimal or String.")
    end
  end

  def +(addend)
    sum = value + addend.value
    CoinDecimal.new(sum, precision)
  end

  def -(subtrahend)
    difference = value - subtrahend.value
    CoinDecimal.new(difference, precision)
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
      if result.length > precision
        result.insert(-(precision + 1), ".")
      else
        "0.#{result.rjust(precision, "0")}"
      end

    negative? ? "-#{result}" : result
  end
end
