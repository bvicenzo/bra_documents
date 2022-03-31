# frozen_string_literal: true

# Libs are following this issue: https://github.com/rails/rails/issues/37835
# Rules to generate a CPF https://www.geradorcpf.com/algoritmo_do_cpf.htm

module BraDocuments
  class CPFGenerator < NationalRegisterBase
    PERSON_NUMBER_SIZE = 9

    class << self
      # Generates a random CPF document number or add verifying digits to one if it's given.
      # It can return only numbers or formatted with mask
      #
      #   BraDocuments::CPFGenerator.generate
      #   # => "86027265892"
      #
      #   BraDocuments::CPFGenerator.generate(formatted: true)
      #   # => "038.857.544-10"
      #
      #   BraDocuments::CPFGenerator.generate(person_number: '123123123')
      #   # => "12312312387"
      #
      #   BraDocuments::CPFGenerator.generate(person_number: '123123123', formatted: true)
      #   # => "123.123.123-87"
      def generate(person_number: nil, formatted: false)
        numbers = number_for('Person', PERSON_NUMBER_SIZE, person_number)
        full_number = complete!(numbers)

        formatted ? Formatter.format(full_number, as: :cpf) : full_number
      end

      # Returns if a CPF has a valid verification digit.
      #
      #   BraDocuments::CPFGenerator.valid_verification_digit?(document: '111.111.111-11')
      #   # => false
      #
      #   BraDocuments::CPFGenerator.valid_verification_digit?(document: '123.456.700-88')
      #   # => true
      #
      #   BraDocuments::CPFGenerator.valid_verification_digit?(document: '12345670088')
      #   # => true
      def valid_verification_digit?(document:)
        raw_document = Formatter.raw(document)
        return false if raw_document.chars.uniq.size == 1

        person_number = raw_document.slice(0..(PERSON_NUMBER_SIZE - 1))
        verified_digit = raw_document.slice(PERSON_NUMBER_SIZE..(raw_document.size - 1))

        generate(person_number: person_number).end_with?(verified_digit)
      end

      private

      def verification_digit_multiplicators_for(numbers)
        (2..numbers.size.next).to_a.reverse
      end
    end
  end
end
