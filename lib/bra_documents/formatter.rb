# frozen_string_literal: true

module BraDocuments
  class Formatter
    NOT_NUMBER = /\D/
    FORMATS = {
      cpf: { pattern: /\A(\d{3})(\d{3})(\d{3})(\d{2})\z/, mask: '%s.%s.%s-%s' },
      cnpj: { pattern: /\A(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})\z/, mask: '%s.%s.%s/%s-%s' }
    }.freeze

    class << self
      # Formats a only numbers CPF or CNPJ in their own mask
      #
      # BraDocuments::Formatter.format('86027265892', as: :cpf) # => "860.272.658-92"
      # BraDocuments::Formatter.format('53855973879456', as: :cnpj) # => "53.855.973/8794-56"
      def format(number, as:)
        raise ArgumentError, "\"#{number.inspect}\" must be a String." unless number.is_a?(String)
        unless known_format?(as)
          raise ArgumentError, "Format \"#{as}\" is not know. Known formats: #{known_formats.join(', ')}."
        end

        format_data = FORMATS[as]

        Kernel.format(format_data[:mask], *format_data[:pattern].match(number).captures)
      end

      def raw(number)
        raise ArgumentError, "\"#{number.inspect}\" must be a String." unless number.is_a?(String)

        number.gsub(NOT_NUMBER, '')
      end

      private

      def known_formats
        @known_formats ||= FORMATS.keys
      end

      def known_format?(format)
        known_formats.include?(format)
      end
    end
  end
end
