# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"
require "forwardable"
require "coin_decimal"

class Satoshis < CoinDecimal
  VERSION   = "0.3.0"
  PRECISION = 8
  ONE       = 100_000_000

  def initialize(value)
    super(value, PRECISION)
  end
end
