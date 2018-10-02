# frozen_string_literal: true

require "spec_helper"

RSpec.describe Satoshis do
  it "has a version number" do
    expect(Satoshis::VERSION).not_to be nil
  end

  it "defines the constant PRECISION with Bitcoin precision (8)" do
    expect(Satoshis::PRECISION).to eq 8
  end

  it "defines the constant ONE with one Bitcoin (100.000.000)" do
    expect(Satoshis::ONE).to eq 100_000_000
  end

  describe ".new" do
    it "returns a instance of CoinDecimal" do
      expect(described_class.new(1)).to be_kind_of CoinDecimal
    end

    it "sets precision as 8" do
      expect(described_class.new(1).precision).to eq 8
    end
  end
end
