# frozen_string_literal: true

RSpec.describe BraDocuments::Matcher do
  describe '.match?' do
    context 'when document is not a string' do
      it 'requires a string' do
        expect { described_class.match?(nil, kind: :rg, mode: :raw) }
          .to raise_error(ArgumentError, '"nil" must be a String.')
      end
    end

    context 'when doument is a string' do
      context 'when kind is unknown' do
        it 'requires a valid document' do
          expect { described_class.match?('123456789011', kind: :rg, mode: :raw) }
            .to raise_error(
              ArgumentError,
              'Unknown document kind ":rg". Known documents: cpf, cnpj.'
            )
        end
      end

      context 'when kind is know' do
        context 'but mode is unknown' do
          it 'requires a valid document' do
            expect { described_class.match?('123456789011', kind: :cpf, mode: :classic) }
              .to raise_error(
                ArgumentError,
                'Unknown document format mode ":classic". Known modes: formatted, raw, any.'
              )
          end
        end

        context 'and mode is know' do
          context 'and kind is CPF' do
            context 'and mode is raw' do
              context 'but is not a raw cpf format' do
                it 'does not match with document number' do
                  expect(described_class).not_to be_match('123.456.700-88', kind: :cpf, mode: :raw)
                end
              end

              context 'and it is a raw cpf format' do
                it 'matches with document number' do
                  expect(described_class).to be_match('12345670088', kind: :cpf, mode: :raw)
                end
              end
            end

            context 'and mode is formatted' do
              context 'but is not a formatted cpf format' do
                it 'does not match with document number' do
                  expect(described_class).not_to be_match('12345670088', kind: :cpf, mode: :formatted)
                end
              end

              context 'and it is a formatted cpf format' do
                it 'matches with document number' do
                  expect(described_class).to be_match('123.456.700-88', kind: :cpf, mode: :formatted)
                end
              end
            end

            context 'and mode is any' do
              context 'but document number does not have a raw format' do
                it 'does not match with document number' do
                  expect(described_class).not_to be_match('123456700889', kind: :cpf, mode: :any)
                end
              end

              context 'and document number has a raw format' do
                it 'matches with document number' do
                  expect(described_class).to be_match('12345670088', kind: :cpf, mode: :any)
                end
              end

              context 'but document number does not have a formatted format' do
                it 'does not match with document number' do
                  expect(described_class).not_to be_match('123.456.700-889', kind: :cpf, mode: :any)
                end
              end

              context 'and document number has a formatted format' do
                it 'matches with document number' do
                  expect(described_class).to be_match('123.456.700-88', kind: :cpf, mode: :any)
                end
              end
            end
          end

          context 'and kind is CNPJ' do
            context 'and mode is raw' do
              context 'but is not a raw cnpj format' do
                it 'does not match with document number' do
                  expect(described_class).not_to be_match('38.917.454/0001-02', kind: :cnpj, mode: :raw)
                end
              end

              context 'and it is a raw cnpj format' do
                it 'matches with document number' do
                  expect(described_class).to be_match('28082405000135', kind: :cnpj, mode: :raw)
                end
              end
            end

            context 'and mode is formatted' do
              context 'but is not a formatted cnpj format' do
                it 'does not match with document number' do
                  expect(described_class).not_to be_match('69749148000120', kind: :cnpj, mode: :formatted)
                end
              end

              context 'and it is a formatted cnpj format' do
                it 'matches with document number' do
                  expect(described_class).to be_match('60.823.604/0001-60', kind: :cnpj, mode: :formatted)
                end
              end
            end

            context 'and mode is any' do
              context 'but document number does not have a raw format' do
                it 'does not match with document number' do
                  expect(described_class).not_to be_match('268648940001512', kind: :cnpj, mode: :any)
                end
              end

              context 'and document number has a raw format' do
                it 'matches with document number' do
                  expect(described_class).to be_match('26864894000151', kind: :cnpj, mode: :any)
                end
              end

              context 'but document number does not have a formatted format' do
                it 'does not match with document number' do
                  expect(described_class).not_to be_match('98.940.209/0001-301', kind: :cnpj, mode: :any)
                end
              end

              context 'and document number has a formatted format' do
                it 'matches with document number' do
                  expect(described_class).to be_match('98.940.209/0001-30', kind: :cnpj, mode: :any)
                end
              end
            end
          end
        end
      end
    end
  end
end
