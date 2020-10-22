# frozen_string_literal: true

RSpec.describe BraDocuments::CPFGenerator do
  describe '.generate' do
    context 'and person number is not sent' do
      context 'and formatted option is not sent' do
        it 'generates a CPF using totally random number' do
          expect(described_class.generate).to be_a_raw_cpf
        end
      end

      context 'and formatted option is sent' do
        context 'and it is false' do
          it 'generates a CPF using totally random number' do
            expect(described_class.generate).to be_a_raw_cpf
          end
        end

        context 'and it is true' do
          it 'generates a formatted CPF using totally random number' do
            expect(described_class.generate(formatted: true)).to be_a_formatted_cpf
          end
        end
      end
    end

    context 'and person number is sent' do
      context 'but it is not a number with 9 digits' do
        it 'raises argument error' do
          expect { described_class.generate(person_number: 'O12345678') }
            .to raise_error(ArgumentError, 'Person number must be a number with 9 digits.')
        end
      end

      context 'and it has the right size' do
        let(:person_number) { '111444777' }

        context 'and formatted option is not sent' do
          it 'generates a CPF number person number' do
            cpf = described_class.generate(person_number: person_number)
            expect(cpf).to start_with(person_number)
            expect(cpf).to end_with('35')
          end
        end

        context 'and formatted option is sent' do
          context 'and it is false' do
            it 'generates a CPF number person number' do
              cpf = described_class.generate(person_number: person_number, formatted: false)
              expect(cpf).to start_with(person_number)
              expect(cpf).to end_with('35')
            end
          end

          context 'and it is true' do
            it 'generates a formatted CPF number person number' do
              expect(described_class.generate(person_number: person_number, formatted: true)).to be_a_formatted_cpf
            end
          end
        end
      end
    end
  end
end
