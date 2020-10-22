# frozen_string_literal: true

module BraDocuments
  class NationalRegisterBase
    class << self
      NOT_NUMBER_PATTERN = /\D/.freeze
      BASE = 11

      private

      def complete!(numbers)
        2.times { numbers.push(verification_digit_for(numbers)) }
        numbers.join
      end

      def number_for(number_description, number_size, given_value)
        given_value = only_digits_for(given_value)
        if !given_value.to_s.empty?
          raise ArgumentError, "#{number_description} number must be a number with #{number_size} digits." unless given_value.size == number_size
          given_value.split('').map(&:to_i)
        else
          number_with(number_size)
        end
      end

      def number_with(size)
        size.times.map { rand(10) }
      end

      def only_digits_for(number)
        number.to_s.gsub(NOT_NUMBER_PATTERN, '')
      end

      def verification_digit_for(numbers)
        verification_digit_multiplicators = verification_digit_multiplicators_for(numbers)
        sum_and_multiplication = sum_and_multiply(numbers, verification_digit_multiplicators)
        verified_digit(sum_and_multiplication)
      end

      def verified_digit(sum_and_multiplication)
        rest = sum_and_multiplication % BASE
        rest < 2 ? 0 : BASE - rest
      end

      def sum_and_multiply(numbers, multiplicators)
        multiplicators.map
          .with_index { |multiplicator, position| numbers[position] * multiplicator }
          .sum
      end
    end
  end
end
