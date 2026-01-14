# frozen_string_literal: true

RSpec.describe BraDocuments::Formatter do
  describe '.format' do
    context 'when document is not a string' do
      it 'requires a string' do
        expect { described_class.format(nil, as: :rg) }.to raise_error(ArgumentError, '"nil" must be a String.')
      end
    end

    context 'when document is a string' do
      context 'when an unknown format is given' do
        it 'raises an exception' do
          expect { described_class.format('123456789011', as: :rg) }
            .to raise_error(ArgumentError, 'Format "rg" is not know. Known formats: cpf, cnpj.')
        end
      end

      context 'when a known format is given' do
        context 'and the format is CPF' do
          context 'but the document number has not 11 digits' do
            it 'raises an exception' do
              expect { described_class.format('12345678901a', as: :cpf) }.to raise_error(NoMethodError)
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
              expect { described_class.format('1234567890123a', as: :cnpj) }.to raise_error(NoMethodError)
            end
          end

          context 'and the document number has 14 digits' do
            it 'formats the number upcasing letters' do
              expect(described_class.format('b2345A78901234', as: :cnpj)).to eq('B2.345.A78/9012-34')
            end
          end
        end
      end
    end
  end

  describe '.raw' do
    context 'when document is not a string' do
      it 'requires a string' do
        expect { described_class.raw(nil) }.to raise_error(ArgumentError, '"nil" must be a String.')
      end
    end

    context 'when document is a string' do
      context 'and kind is CPF' do
        context 'and document is only number' do
          it 'removes all not numbers from string' do
            expect(described_class.raw('123.456.077-88')).to eq('12345607788')
          end
        end

        context 'and document is alphanumeric' do
          it 'removes all not numbers from string' do
            expect(described_class.raw('AN.ZZE.NVM/0001-15')).to eq('000115')
          end
        end
      end

      context 'and kind is cnpj' do
        context 'and document is only number' do
          it 'removes all not alphanumeric from string' do
            expect(described_class.raw('123.456.077-88', kind: :cnpj)).to eq('12345607788')
          end
        end

        context 'and document is alphanumeric' do
          it 'removes all not alphanumeric from string' do
            expect(described_class.raw('AN.ZZE.NVM/0001-15', kind: :cnpj)).to eq('ANZZENVM000115')
          end
        end
      end
    end
  end
end
