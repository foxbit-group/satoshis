# frozen_string_literal: true

require "spec_helper"

RSpec.describe CoinDecimal do
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

  describe ".new" do
    context "with value as nil" do
      it "raises ArgumentError" do
        expect { described_class.new(nil) }.to raise_error ArgumentError, "Value can't be nil."
      end
    end

    context "with value as an integer" do
      it "uses that value as the fractional-part" do
        expect(described_class.new(42).to_s).to eq "0.00000042"
      end
    end

    context "with value as a string" do
      it "uses that value as the integer-part" do
        expect(described_class.new("3").to_s).to eq "3.0"
      end
    end

    context "with value as a BigDecimal" do
      it "uses that value as the full number" do
        expect(described_class.new("3.007").to_s).to eq "3.007"
      end
    end

    context "with a value that is not Integer, BigDecimal or String" do
      it "raises ArgumentError" do
        expect { described_class.new(0.1) }.to raise_error ArgumentError, "Value must be Integer, BigDecimal or String."
      end
    end

    context "with an integer" do
      describe "#value" do
        valid_cases.each do |c|
          integer = c[0]

          it "from #{integer} to #{integer}" do
            expect(described_class.new(integer).value).to eq integer
          end
        end
      end

      describe "#formatted" do
        valid_cases.each do |c|
          integer = c[0]
          string  = c[1]

          it "from #{integer} to #{string}" do
            expect(described_class.new(integer).formatted).to eq string
          end
        end
      end

      describe "#formatted with short: false" do
        valid_cases.each do |c|
          integer         = c[0]
          string_complete = c[2]

          it "from #{integer} to #{string_complete}" do
            expect(described_class.new(integer).formatted(short: false)).to eq string_complete
          end
        end
      end
    end

    context "with a BigDecimal" do
      describe "#value" do
        valid_cases.each do |c|
          string  = c[1]
          integer = c[0]

          it "from #{string} to #{integer}" do
            expect(described_class.new(BigDecimal.new(string)).value).to eq integer
          end
        end
      end

      describe "#formatted" do
        valid_cases.each do |c|
          string = c[1]

          it "from #{string} to #{string} (keep the same)" do
            expect(described_class.new(BigDecimal.new(string)).formatted).to eq string
          end
        end
      end

      describe "#formatted with short: false" do
        valid_cases.each do |c|
          string          = c[1]
          string_complete = c[2]

          it "from #{string} to #{string_complete}" do
            expect(described_class.new(BigDecimal.new(string)).formatted(short: false)).to eq string_complete
          end
        end
      end
    end

    context "with a String" do
      describe "#value" do
        valid_cases.each do |c|
          string  = c[1]
          integer = c[0]

          it "from #{string} to #{integer}" do
            expect(described_class.new(string).value).to eq integer
          end
        end
      end

      describe "#formatted" do
        valid_cases.each do |c|
          string = c[1]

          it "from #{string} to #{string} (keep the same)" do
            expect(described_class.new(string).formatted).to eq string
          end
        end
      end

      describe "#formatted with short: false" do
        valid_cases.each do |c|
          string          = c[1]
          string_complete = c[2]

          it "from #{string} to #{string_complete}" do
            expect(described_class.new(string).formatted(short: false)).to eq string_complete
          end
        end
      end
    end

    context "with a custom precision" do
      it "sets that precision" do
        expect(described_class.new(1, 4).to_s).to eq "0.0001"
      end
    end

    context "with a nagative precision" do
      it "raises ArgumentError" do
        expect { described_class.new(1, -1) }.to raise_error ArgumentError, "Precision can't be negative."
      end
    end

    context "with precision as a non Integer" do
      it "raises ArgumentError" do
        expect { described_class.new(1, "1") }.to raise_error ArgumentError, "Precision must be an Integer."
      end
    end

    context "with a precision greater than 32" do
      it "raises ArgumentError" do
        expect { described_class.new(1, 33) }.to raise_error ArgumentError, "Precision must be less than or equal to 32."
      end
    end
  end

  describe ".ensure_integer" do
    context "with a Integer" do
      it "returns that Integer" do
        expect(described_class.ensure_integer(123)).to eq 123
      end
    end

    context "with a BigDecimal" do
      it "returns the equivalent Integer" do
        expect(described_class.ensure_integer(BigDecimal.new("1.001"))).to eq 100100000
      end
    end

    context "with a String" do
      it "returns the equivalent Integer" do
        expect(described_class.ensure_integer("42.000042")).to eq 4200004200
      end
    end
  end

  describe "#positive?" do
    context "with zero" do
      specify { expect(described_class.new(0).positive?).to eq false }
    end

    context "with 1" do
      specify { expect(described_class.new(1).positive?).to eq true }
    end

    context "with -1" do
      specify { expect(described_class.new(-1).positive?).to eq false }
    end
  end

  describe "#negative?" do
    context "with zero" do
      specify { expect(described_class.new(0).negative?).to eq false }
    end

    context "with 1" do
      specify { expect(described_class.new(1).negative?).to eq false }
    end

    context "with -1" do
      specify { expect(described_class.new(-1).negative?).to eq true }
    end
  end

  describe "#+" do
    let(:value_1) { described_class.new(2000) }

    let(:value_2) { described_class.new(3000) }

    let(:sum) { value_1 + value_2 }

    it "retruns a CoinDecimal instance" do
      expect(sum.class).to eq described_class
    end

    it "returns the correct value (5000 satoshis)" do
      expect(sum.value).to eq 5000
    end
  end

  describe "#-" do
    let(:value_1) { described_class.new(50000000) }

    let(:value_2) { described_class.new(40000000) }

    let(:difference) { value_1 - value_2 }

    it "retruns a CoinDecimal instance" do
      expect(difference.class).to eq described_class
    end

    it "returns the correct value (10000000 satoshis)" do
      expect(difference.value).to eq 10000000
    end
  end

  describe "#to_s" do
    subject(:amount) { described_class.new(42) }

    it "is an alias to formatted" do
      expect(amount.method(:to_s)).to eq amount.method(:formatted)
    end
  end

  describe "#to_d" do
    it "returns the value in BigDecimal format" do
      expect(described_class.new(4200000042).to_d).to eq BigDecimal.new("42.00000042")
    end
  end

  it "decrement high precision numbers correctly" do
    v1 = described_class.new(30000, 32)
    v2 = described_class.new(10000, 32)

    expect((v1 - v2).to_s).to eq "0.0000000000000000000000000002"
  end
end
