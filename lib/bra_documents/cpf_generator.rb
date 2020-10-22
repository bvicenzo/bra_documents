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
      # BraDocuments::CPFGenerator.generate # => "86027265892"
      # BraDocuments::CPFGenerator.generate(formatted: true) # => "038.857.544-10"
      # BraDocuments::CPFGenerator.generate(person_number: '123123123') # => "12312312387"
      # BraDocuments::CPFGenerator.generate(person_number: '123123123', formatted: true) # => "123.123.123-87"
      def generate(person_number: nil, formatted: false)
        numbers = number_for('Person', PERSON_NUMBER_SIZE, person_number)
        full_number = complete!(numbers)

        formatted ?  Formatter.format(full_number, as: :cpf) : full_number
      end

      private

      def verification_digit_multiplicators_for(numbers)
        (2..numbers.size.next).to_a.reverse
      end
    end
  end
end
