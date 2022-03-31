# frozen_string_literal: true

RSpec.describe BraDocuments::CNPJGenerator do
  describe '.generate' do
    context 'when company inscrition number is not sent' do
      context 'and matrix/subsidiary number is not sent' do
        context 'and no formatted option is sent' do
          it 'generates a CNPJ using totally random number' do
            expect(described_class.generate).to be_a_raw_cnpj
          end
        end

        context 'and formatted option is sent' do
          context 'and it is false' do
            it 'generates a CNPJ using totally random number' do
              expect(described_class.generate).to be_a_raw_cnpj
            end
          end

          context 'and it is true' do
            it 'generates a formatted CNPJ using totally random number' do
              expect(described_class.generate(formatted: true)).to be_a_formatted_cnpj
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

              expect(cnpj).to be_a_raw_cnpj
              expect(cnpj).to include(matrix_subsidiary_number)
            end
          end

          context 'and formatted option is sent' do
            context 'and it is false' do
              it 'generates a CNPJ number matrix/subsidiary number' do
                cnpj = described_class.generate(matrix_subsidiary_number: '0001', formatted: false)

                expect(cnpj).to be_a_raw_cnpj
                expect(cnpj).to include(matrix_subsidiary_number)
              end
            end

            context 'and it is true' do
              it 'generates a formatted CNPJ number matrix/subsidiary number' do
                cnpj = described_class.generate(matrix_subsidiary_number: '0001', formatted: true)

                expect(cnpj).to be_a_formatted_cnpj
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

              expect(cnpj).to be_a_raw_cnpj
              expect(cnpj).to include(company_number)
            end
          end

          context 'and formatted option is sent' do
            context 'and formatted option is false' do
              it 'generates a CNPJ using giving company number' do
                cnpj = described_class.generate(company_number: company_number, formatted: false)

                expect(cnpj).to be_a_raw_cnpj
                expect(cnpj).to include(company_number)
              end
            end

            context 'and formatted option is true' do
              it 'generates a formatted CNPJ using giving company number' do
                cnpj = described_class.generate(company_number: company_number, formatted: true)

                expect(cnpj).to be_a_formatted_cnpj
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

                expect(cnpj).to be_a_raw_cnpj
                expect(cnpj).to include(matrix_subsidiary_number)
              end
            end

            context 'and formatted option is sent' do
              context 'and it is false' do
                it 'generates a CNPJ using giving company and matrix/subsidiary number' do
                  cnpj = described_class.generate(company_number: company_number, matrix_subsidiary_number: matrix_subsidiary_number, formatted: false)

                  expect(cnpj).to be_a_raw_cnpj
                  expect(cnpj).to include(matrix_subsidiary_number)
                end
              end

              context 'and it is true' do
                it 'generates a formatted CNPJ using giving company and matrix/subsidiary number' do
                  cnpj = described_class.generate(company_number: company_number, matrix_subsidiary_number: matrix_subsidiary_number, formatted: true)

                  expect(cnpj).to be_a_formatted_cnpj
                  expect(cnpj).to include(matrix_subsidiary_number)
                end
              end
            end
          end
        end
      end
    end
  end

  describe '#valid_verification_digit?' do
    context 'when cnpj is raw' do
      context 'and all numbers are equal' do
        it 'is invalid verification digit' do
          expect(described_class).not_to be_valid_verification_digit(document: '11111111111111')
        end
      end

      context 'and numbers are different' do
        context 'but digit calculation does not match' do
          it 'is invalid verification digit' do
            expect(described_class).not_to be_valid_verification_digit(document: '75777407000128')
          end
        end

        context 'and digit calculation matches' do
          it 'is valid verification digit' do
            expect(described_class).to be_valid_verification_digit(document: '26086824000110')
          end
        end
      end
    end

    context 'when cnpj is formatted' do
      context 'and all numbers are equal' do
        it 'is invalid verification digit' do
          expect(described_class).not_to be_valid_verification_digit(document: '11.111.111/1111-11')
        end
      end

      context 'and numbers are different' do
        context 'but digit calculation does not match' do
          it 'is invalid verification digit' do
            expect(described_class).not_to be_valid_verification_digit(document: '57.153.713/0001-01')
          end
        end

        context 'and digit calculation matches' do
          it 'is valid verification digit' do
            expect(described_class).to be_valid_verification_digit(document: '57.153.713/0001-02')
          end
        end
      end
    end
  end
end
