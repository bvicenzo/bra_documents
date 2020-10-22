# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'CNPJ Matcher' do
  describe '#a_formatted_cnpj' do
    context 'when CNPJ format does not match' do
      it 'fails test' do
        cnpj_example = '74.710.049\4091-45'
        expect { expect(cnpj_example).to a_formatted_cnpj }
          .to fail_with(
            "Was expected `#{cnpj_example.inspect}` to be a Brazilian CNPJ document number but it isn't.\n"\
            "A CNPJ has the following format XX.XXX.XXX/XXXX-XX where X are numbers from 0 to 9.\n"
          )
      end
    end

    context 'when CNPJ format matches' do
      it 'passes test' do
        expect('74.710.049/4091-45').to a_formatted_cnpj
      end
    end
  end

  describe '#be_a_formatted_cnpj' do
    context 'when CNPJ format does not match' do
      it 'fails test' do
        cnpj_example = '74.710.049\4091-45'
        expect { expect(cnpj_example).to be_a_formatted_cnpj }
          .to fail_with(
            "Was expected `#{cnpj_example.inspect}` to be a Brazilian CNPJ document number but it isn't.\n"\
            "A CNPJ has the following format XX.XXX.XXX/XXXX-XX where X are numbers from 0 to 9.\n"
          )
      end
    end

    context 'when CNPJ format matches' do
      it 'passes test' do
        expect('74.710.049/4091-45').to be_a_formatted_cnpj
      end
    end
  end

  describe '#a_raw_cnpj' do
    context 'when CNPJ format does not match' do
      it 'fails test' do
        cnpj_example = '616596251168889'
        expect { expect(cnpj_example).to a_raw_cnpj }
          .to fail_with(
            "Was expected `#{cnpj_example.inspect}` to be a raw Brazilian cnpj document number but it isn't.\n"\
            "A raw CNPJ has the following format XXXXXXXXXXXXXX where X are numbers from 0 to 9.\n"\
          )
      end
    end

    context 'when CNPJ format matches' do
      it 'passes test' do
        expect('61659625116888').to a_raw_cnpj
      end
    end
  end

  describe '#be_a_raw_cnpj' do
    context 'when CNPJ format does not match' do
      it 'fails test' do
        cnpj_example = '616596251168889'
        expect { expect(cnpj_example).to be_a_raw_cnpj }
          .to fail_with(
            "Was expected `#{cnpj_example.inspect}` to be a raw Brazilian cnpj document number but it isn't.\n"\
            "A raw CNPJ has the following format XXXXXXXXXXXXXX where X are numbers from 0 to 9.\n"\
          )
      end
    end

    context 'when CNPJ format matches' do
      it 'passes test' do
        expect('61659625116888').to be_a_raw_cnpj
      end
    end
  end
end
