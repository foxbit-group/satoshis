# Satoshis

[![Build Status](https://travis-ci.org/bsoares/satoshis.svg?branch=master)](https://travis-ci.org/bsoares/satoshis)
[![Maintainability](https://api.codeclimate.com/v1/badges/69b087f6c2d3cfbb0fa2/maintainability)](https://codeclimate.com/github/bsoares/satoshis/maintainability)
[![Gem Version](https://badge.fury.io/rb/satoshis.svg)](https://badge.fury.io/rb/satoshis)

A Ruby gem to manipulate Bitcoin money without loss of precision.

## Why?

In simple operations like `0.3 - 0.1` (using `Float` data types) the result may be a bit strange:

```ruby
difference = 0.3 - 0.1

puts difference
# 0.19999999999999998
```

Using the **Satoshis** gem you get:

```ruby
difference = Satoshis.new("0.3") - Satoshis.new("0.1")

puts difference.to_s
# "0.2"
```

And you can do some conversions of bitcoin values:

```ruby
satoshis = 420000
amount   = Satoshis.new(satoshis)

puts amount.to_s
# "0.0042"
# String

puts amount.to_d
# 0.42e-2
# BigDecimal

puts amount.to_i
# 420000
# Integer (satoshis)
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "satoshis"
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install satoshis
```

## Custom Precision

Use the class `CoinDecimal` passing the argument `precision`:

```ruby
satoshis = 42
amount   = CoinDecimal.new(satoshis, 10)

puts amount.to_s
# "0.0000000042"
# String
```
