# frozen_string_literal: true

module BraDocuments
  class Formatter
    FORMATS = {
      cpf: { pattern: /\A(\d{3})(\d{3})(\d{3})(\d{2})\z/, mask: '%s.%s.%s-%s' },
      cnpj: { pattern: /\A(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})\z/, mask: '%s.%s.%s/%s-%s'}
    }.freeze

    def self.format(number, as:)
      format_data = FORMATS[as]

      Kernel.format(format_data[:mask], *format_data[:pattern].match(number).captures)
    end
  end
end

