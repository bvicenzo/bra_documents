# frozen_string_literal: true

module BraDocuments
  class Matcher
    FORMATS = {
      cpf: { formatted: /\A(\d{3}\.){2}\d{3}-\d{2}\z/, raw: /\A\d{11}\z/ },
      cnpj: { formatted: /\A\d{2}.\d{3}\.\d{3}\/\d{4}-\d{2}\z/, raw: /\A\d{14}\z/ }
    }.freeze

    class << self
      # Macthes with Brazilian CPF and CNPJ documents.
      #
      #   BraDocuments::Matcher.match?('11111111111', kind: :cpf, mode: :raw)
      #   # => true
      #
      #   BraDocuments::Matcher.match?('11111111111', kind: :cpf, mode: :formatted)
      #   # => false
      #
      #   BraDocuments::Matcher.match?('11111111111', kind: :cnpj, mode: :raw)
      #   # => false
      #
      #   BraDocuments::Matcher.match?('90.978.812/0001-07', kind: :cnpj, mode: :formatted)
      #   # => true
      def match?(number, kind:, mode:)
        raise ArgumentError, "\"#{number.inspect}\" must be a String." unless number.is_a?(String)

        unless known_format?(kind)
          raise ArgumentError, "Unknown document kind \"#{kind.inspect}\". Known documents: #{known_formats.join(', ')}."
        end

        unless known_mode?(mode)
          raise ArgumentError, "Unknown document format mode \"#{mode.inspect}\". Known modes: #{known_modes.join(', ')}."
        end

        formats_to_match(kind, mode).any? { |format| format.match?(number) }
      end

      private

      def known_formats
        @known_formats ||= FORMATS.keys
      end

      def known_modes
        @known_modes ||= FORMATS[known_formats.first].keys << :any
      end

      def known_format?(format)
        known_formats.include?(format)
      end

      def known_mode?(mode)
        known_modes.include?(mode)
      end

      def formats_to_match(kind, mode)
        document_formats = FORMATS[kind]

        mode == :any ? document_formats.values : [document_formats[mode]]
      end
    end
  end
end
