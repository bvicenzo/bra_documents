# frozen_string_literal: true

module BraDocuments
  class Formatter
    FORMATS = {
      cpf: { pattern: /\A(\d{3})(\d{3})(\d{3})(\d{2})\z/, mask: '%s.%s.%s-%s' },
      cnpj: { pattern: /\A(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})\z/, mask: '%s.%s.%s/%s-%s'}
    }.freeze

    # Formats a only numbers CPF or CNPJ in their own mask
    #
    # BraDocuments::Formatter.format('86027265892', as: :cpf) # => "860.272.658-92"
    # BraDocuments::Formatter.format('53855973879456', as: :cnpj) # => "53.855.973/8794-56"
    def self.format(number, as:)
      format_data = FORMATS[as]

      Kernel.format(format_data[:mask], *format_data[:pattern].match(number).captures)
    end
  end
end

