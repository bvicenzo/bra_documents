# frozen_string_literal: true

RSpec.describe BraDocuments::CNPJGenerator do
  describe '.generate' do
    context 'when company inscrition number is not sent' do
      context 'and matrix/subsidiary number is not sent' do
        context 'and no formatted option is sent' do
          it 'generates a CNPJ using totally random number' do
            expect(described_class.generate).to match(/\A\d{14}\z/)
          end
        end

        context 'and formatted option is sent' do
          context 'and it is false' do
            it 'generates a CNPJ using totally random number' do
              expect(described_class.generate).to match(/\A\d{14}\z/)
            end
          end

          context 'and it is true' do
            it 'generates a formatted CNPJ using totally random number' do
              expect(described_class.generate(formatted: true)).to match(/^(\d{2}\.\d{3}\.\d{3}\/\d{4})-(\d{2})$/)
            end
          end
        end
      end

      context 'and matrix/subsidiary number is sent' do
        context 'but it is not a number with 4 digits' do
          it 'raises argument error' do
            expect { described_class.generate(matrix_subsidiary_number: 'OOO1') }
              .to raise_error(ArgumentError, 'Matrix or subsidiary number must be a number with 4 digits.')
          end
        end

        context 'and it has the right size' do
          let(:matrix_subsidiary_number) { '0001' }

          context 'and no formatted option is sent' do
            it 'generates a CNPJ number matrix/subsidiary number' do
              cnpj = described_class.generate(matrix_subsidiary_number: '0001')

              expect(cnpj).to match(/\A\d{14}\z/)
              expect(cnpj).to include(matrix_subsidiary_number)
            end
          end

          context 'and formatted option is sent' do
            context 'and it is false' do
              it 'generates a CNPJ number matrix/subsidiary number' do
                cnpj = described_class.generate(matrix_subsidiary_number: '0001', formatted: false)

                expect(cnpj).to match(/\A\d{14}\z/)
                expect(cnpj).to include(matrix_subsidiary_number)
              end
            end

            context 'and it is true' do
              it 'generates a formatted CNPJ number matrix/subsidiary number' do
                cnpj = described_class.generate(matrix_subsidiary_number: '0001', formatted: true)

                expect(cnpj).to match(/^(\d{2}\.\d{3}\.\d{3}\/\d{4})-(\d{2})$/)
                expect(cnpj).to include(matrix_subsidiary_number)
              end
            end
          end
        end
      end
    end

    context 'when company inscrition number is sent' do
      context 'but it is not a number with 8 digits' do
          it 'raises argument error' do
            expect { described_class.generate(matrix_subsidiary_number: 'OOO1') }
              .to raise_error(ArgumentError, 'Matrix or subsidiary number must be a number with 4 digits.')
          end
      end

      context 'and it has the right size' do
        let(:company_number) { '12345678' }

        context 'and matrix/subsidiary number is not sent' do
          context 'and formatted option is not sent' do
            it 'generates a CNPJ using giving company number' do
              cnpj = described_class.generate(company_number: company_number)

              expect(cnpj).to match(/\A\d{14}\z/)
              expect(cnpj).to include(company_number)
            end
          end

          context 'and formatted option is sent' do
            context 'and formatted option is false' do
              it 'generates a CNPJ using giving company number' do
                cnpj = described_class.generate(company_number: company_number, formatted: false)

                expect(cnpj).to match(/\A\d{14}\z/)
                expect(cnpj).to include(company_number)
              end
            end

            context 'and formatted option is true' do
              it 'generates a formatted CNPJ using giving company number' do
                cnpj = described_class.generate(company_number: company_number, formatted: true)

                expect(cnpj).to match(/^(\d{2}\.\d{3}\.\d{3}\/\d{4})-(\d{2})$/)
                expect(cnpj).to include('12.345.678')
              end
            end
          end
        end

        context 'and matrix/subsidiary number is sent' do
          context 'but it is not a number with 4 digits' do
            it 'raises argument error' do
              expect { described_class.generate(company_number: company_number, matrix_subsidiary_number: 'OOO1') }
                .to raise_error(ArgumentError, 'Matrix or subsidiary number must be a number with 4 digits.')
            end
          end

          context 'and matrix/subsidiary number has the right size' do
            let(:matrix_subsidiary_number) { '0002' }

            context 'and formatted option is not sent' do
              it 'generates a CNPJ using giving company and matrix/subsidiary number' do
                cnpj = described_class.generate(company_number: company_number, matrix_subsidiary_number: matrix_subsidiary_number)

                expect(cnpj).to match(/\A\d{14}\z/)
                expect(cnpj).to include(matrix_subsidiary_number)
              end
            end

            context 'and formatted option is sent' do
              context 'and it is false' do
                it 'generates a CNPJ using giving company and matrix/subsidiary number' do
                  cnpj = described_class.generate(company_number: company_number, matrix_subsidiary_number: matrix_subsidiary_number, formatted: false)

                  expect(cnpj).to match(/\A\d{14}\z/)
                  expect(cnpj).to include(matrix_subsidiary_number)
                end
              end

              context 'and it is true' do
                it 'generates a formatted CNPJ using giving company and matrix/subsidiary number' do
                  cnpj = described_class.generate(company_number: company_number, matrix_subsidiary_number: matrix_subsidiary_number, formatted: true)

                  expect(cnpj).to match(/^(\d{2}\.\d{3}\.\d{3}\/\d{4})-(\d{2})$/)
                  expect(cnpj).to include(matrix_subsidiary_number)
                end
              end
            end
          end
        end
      end
    end
  end
end
