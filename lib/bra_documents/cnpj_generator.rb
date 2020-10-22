# frozen_string_literal: true

# Libs are following this issue: https://github.com/rails/rails/issues/37835
# Rules to generate a CPF https://www.geradorcpf.com/algoritmo_do_cpf.htm

module BraDocuments
  class CNPJGenerator < NationalRegisterBase
    COMPANY_NUMBER_SIZE = 8
    MATRIX_SUBSIDIARY_SIZE = 4

    class << self
      # Generates a random CNPJ document number or add verifying digits to one if it's given.
      # It can return only numbers or formatted with mask
      #
      # BraDocuments::CNPJGenerator.generate # => "62885807804809"
      # BraDocuments::CNPJGenerator.generate(formatted: true) # => "53.855.973/0664-39"
      # BraDocuments::CNPJGenerator.generate(company_number: '53855973') # => "53855973879456"
      # BraDocuments::CNPJGenerator.generate(company_number: '53855973', formatted: true) # => "53.855.973/8189-02"
      # BraDocuments::CNPJGenerator.generate(company_number: '53855973', matrix_subsidiary_number: '0001') # => "53855973000179"
      # BraDocuments::CNPJGenerator.generate(company_number: '53855973', matrix_subsidiary_number: '0001', formatted: true) # => "53.855.973/0001-79"
      def generate(company_number: nil, matrix_subsidiary_number: nil, formatted: false)
        company_number = number_for('Company', COMPANY_NUMBER_SIZE, company_number)
        matrix_subsidiary_number = number_for('Matrix or subsidiary', MATRIX_SUBSIDIARY_SIZE, matrix_subsidiary_number)
        numbers = company_number + matrix_subsidiary_number

        full_number = complete!(numbers)

        formatted ?  Formatter.format(full_number, as: :cnpj) : full_number
      end

      private

      def verification_digit_multiplicators_for(numbers)
        (2..(numbers.size - 7)).to_a.reverse + (2..9).to_a.reverse
      end
    end
  end
end
