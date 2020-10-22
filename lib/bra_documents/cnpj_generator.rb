# frozen_string_literal: true

# Libs are following this issue: https://github.com/rails/rails/issues/37835
# Rules to generate a CPF https://www.geradorcpf.com/algoritmo_do_cpf.htm

module BraDocuments
  class CNPJGenerator < NationalRegisterBase
    COMPANY_NUMBER_SIZE = 8
    MATRIX_SUBSIDIARY_SIZE = 4

    class << self
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
