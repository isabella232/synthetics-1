require 'spec_helper'

describe Synthetics::Util do
  describe '.deep_snakeify_keys' do
    let(:input) do
      {
        'key_one' => 1,
        'keyTwo' => 2
      }
    end
    let(:expected) do
      {
        key_one: 1,
        key_two: 2
      }
    end

    it 'transforms all of the string keys into snakeified symbols' do
      expect(subject.deep_snakeify_keys(input)).to eq(expected)
    end
  end

  describe '.deep_camelize_keys' do
    let(:input) do
      {
        key_one: 1,
        keyTwo: 2
      }
    end
    let(:expected) do
      {
        'keyOne' => 1,
        'keyTwo' => 2
      }
    end

    it 'transforms all of the symbol keys into camelized strings' do
      expect(subject.deep_camelize_keys(input)).to eq(expected)
    end
  end

  describe '.deep_transform_keys' do
    let(:input) do
      [
        {
          'one' => [
            {
              'two' => [1, 2]
            }
          ]
        }
      ]
    end
    let(:expected) do
      [
        {
          'eno' => [
            {
              'owt' => [1, 2]
            }
          ]
        }
      ]
    end
    let(:block) { proc(&:reverse) }

    it 'transforms the keys based on the given block' do
      expect(subject.deep_transform_keys(input, &block)).to eq(expected)
    end
  end

  describe '.camelize' do
    let(:hash) do
      {
        'alreadyCamel' => 'alreadyCamel',
        'was_snake' => 'wasSnake'
      }
    end

    it 'converts a string to camelCase' do
      hash.each do |actual, expected|
        expect(subject.camelize(actual)).to eq(expected)
      end
    end
  end

  describe '.snakeify' do
    let(:hash) do
      {
        'already_snake' => 'already_snake',
        'wasCamel' => 'was_camel'
      }
    end

    it 'converts a string to snake_case' do
      hash.each do |actual, expected|
        expect(subject.snakeify(actual)).to eq(expected)
      end
    end
  end
end
