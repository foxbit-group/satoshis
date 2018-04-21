# frozen_string_literal: true

RSpec.describe Satoshis do
  it "has a version number" do
    expect(Satoshis::VERSION).not_to be nil
  end

  valid_cases = [
    [                  0 ,           "0.0"        ,           "0.00000000"],
    [                  1 ,           "0.00000001" ,           "0.00000001"],
    [                  2 ,           "0.00000002" ,           "0.00000002"],
    [                  9 ,           "0.00000009" ,           "0.00000009"],
    [                123 ,           "0.00000123" ,           "0.00000123"],
    [            1234567 ,           "0.01234567" ,           "0.01234567"],
    [           12345678 ,           "0.12345678" ,           "0.12345678"],
    [           12340000 ,           "0.1234"     ,           "0.12340000"],
    [           10000000 ,           "0.1"        ,           "0.10000000"],
    [           99999999 ,           "0.99999999" ,           "0.99999999"],
    [          100000000 ,           "1.0"        ,           "1.00000000"],
    [          100000001 ,           "1.00000001" ,           "1.00000001"],
    [          199999999 ,           "1.99999999" ,           "1.99999999"],
    [          999999999 ,           "9.99999999" ,           "9.99999999"],
    [          990000000 ,           "9.9"        ,           "9.90000000"],
    [        99900000000 ,         "999.0"        ,         "999.00000000"],
    [      1000000000000 ,       "10000.0"        ,       "10000.00000000"],
    [ 100000000000000000 ,  "1000000000.0"        ,  "1000000000.00000000"],
    [ 100000000000000001 ,  "1000000000.00000001" ,  "1000000000.00000001"],
    [ 100000000000000009 ,  "1000000000.00000009" ,  "1000000000.00000009"],
    [ 999999999999999999 ,  "9999999999.99999999" ,  "9999999999.99999999"],
    [                 -1 ,          "-0.00000001" ,          "-0.00000001"],
    [                 -2 ,          "-0.00000002" ,          "-0.00000002"],
    [                 -9 ,          "-0.00000009" ,          "-0.00000009"],
    [               -123 ,          "-0.00000123" ,          "-0.00000123"],
    [           -1234567 ,          "-0.01234567" ,          "-0.01234567"],
    [          -12345678 ,          "-0.12345678" ,          "-0.12345678"],
    [          -12340000 ,          "-0.1234"     ,          "-0.12340000"],
    [          -10000000 ,          "-0.1"        ,          "-0.10000000"],
    [          -99999999 ,          "-0.99999999" ,          "-0.99999999"],
    [         -100000000 ,          "-1.0"        ,          "-1.00000000"],
    [         -100000001 ,          "-1.00000001" ,          "-1.00000001"],
    [         -199999999 ,          "-1.99999999" ,          "-1.99999999"],
    [         -999999999 ,          "-9.99999999" ,          "-9.99999999"],
    [         -990000000 ,          "-9.9"        ,          "-9.90000000"],
    [       -99900000000 ,        "-999.0"        ,        "-999.00000000"],
    [     -1000000000000 ,      "-10000.0"        ,      "-10000.00000000"],
    [-100000000000000000 , "-1000000000.0"        , "-1000000000.00000000"],
    [-100000000000000001 , "-1000000000.00000001" , "-1000000000.00000001"],
    [-100000000000000009 , "-1000000000.00000009" , "-1000000000.00000009"],
    [-999999999999999999 , "-9999999999.99999999" , "-9999999999.99999999"],
  ]

  describe ".from_integer" do
    describe "passing nil as argument" do
      it "raises ArgumentError" do
        expect { described_class.from_integer(nil) }.to raise_error ArgumentError
      end
    end

    describe "#value" do
      valid_cases.each do |c|
        integer = c[0]

        it "from #{integer} to #{integer}" do
          expect(described_class.from_integer(integer).value).to eq integer
        end
      end
    end

    describe "#string" do
      valid_cases.each do |c|
        integer         = c[0]
        string_complete = c[2]

        it "from #{integer} to #{string_complete}" do
          expect(described_class.from_integer(integer).string).to eq string_complete
        end
      end
    end

    describe "#string_formatted" do
      valid_cases.each do |c|
        integer = c[0]
        string  = c[1]

        it "from #{integer} to #{string}" do
          expect(described_class.from_integer(integer).string_formatted).to eq string
        end
      end
    end
  end

  describe ".from_big_decimal" do
    describe "passing nil as argument" do
      it "raises ArgumentError" do
        expect { described_class.from_big_decimal(nil) }.to raise_error ArgumentError
      end
    end

    describe "#value" do
      valid_cases.each do |c|
        string  = c[1]
        integer = c[0]

        it "from #{string} to #{integer}" do
          expect(described_class.from_big_decimal(BigDecimal.new(string)).value).to eq integer
        end
      end
    end

    describe "#string" do
      valid_cases.each do |c|
        string          = c[1]
        string_complete = c[2]

        it "from #{string} to #{string_complete}" do
          expect(described_class.from_big_decimal(BigDecimal.new(string)).string).to eq string_complete
        end
      end
    end

    describe "#string_formatted" do
      valid_cases.each do |c|
        string = c[1]

        it "from #{string} to #{string} (keep the same)" do
          expect(described_class.from_big_decimal(BigDecimal.new(string)).string_formatted).to eq string
        end
      end
    end
  end

  describe ".from_string" do
    it "uses the method .from_big_decimal" do
      expect(described_class.from_string("42.00000042").value).to eq 4200000042
    end

    describe "passing nil as argument" do
      it "raises ArgumentError" do
        expect { described_class.from_big_decimal(nil) }.to raise_error ArgumentError
      end
    end
  end

  describe "#+" do
    let(:value_1) { described_class.new(2000) }

    let(:value_2) { described_class.new(3000) }

    let(:sum) { value_1 + value_2 }

    it "retruns a Satoshis instance" do
      expect(sum.class).to eq described_class
    end

    it "returns the correct value (5000 satoshis)" do
      expect(sum.value).to eq 5000
    end
  end

  describe "#to_s" do
    subject(:money) { described_class.new(0) }

    it "is an alias to string_formatted method" do
      expect(money.method(:to_s)).to eq money.method(:string_formatted)
    end
  end

  describe "#to_d" do
    it "returns the value in BigDecimal format" do
      expect(described_class.new(4200000042).to_d).to eq BigDecimal.new("42.00000042")
    end
  end
end
