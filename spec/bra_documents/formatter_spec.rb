# frozen_string_literal: true

RSpec.describe BraDocuments::Formatter do
  describe '.format' do
    context 'when an unknown format is given' do
      it 'raises an exception' do
        expect { described_class.format('123456789011', as: :rg) }
          .to raise_error(NoMethodError, "undefined method `[]' for nil:NilClass")
      end
    end

    context 'when a known format is given' do
      context 'and the format is CPF' do
        context 'but the document number has not 11 digits' do
          it 'raises an exception' do
            expect { described_class.format('12345678901a', as: :cpf) }
              .to raise_error(NoMethodError, "undefined method `captures' for nil:NilClass")
          end
        end

        context 'and the document number has 11 digits' do
          it 'formats the number' do
            expect(described_class.format('12345678911', as: :cpf)).to eq('123.456.789-11')
          end
        end
      end

      context 'and the format is CNPJ' do
        context 'but the document number has not 14 digits' do
          it 'raises an exception' do
            expect { described_class.format('1234567890123a', as: :cnpj) }
              .to raise_error(NoMethodError, "undefined method `captures' for nil:NilClass")
          end
        end

        context 'and the document number has 14 digits' do
          it 'formats the number' do
            expect(described_class.format('12345678901234', as: :cnpj)).to eq('12.345.678/9012-34')
          end
        end
      end
    end
  end
end

