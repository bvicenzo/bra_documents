# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'CPF Matcher' do
  describe '#a_formatted_cpf' do
    context 'when CPF format does not match' do
      it 'fails test' do
        cpf_example = '123.4566.987-12'
        expect { expect(cpf_example).to a_formatted_cpf }
          .to fail_with(
            "Was expected `#{cpf_example.inspect}` to be a Brazilian CPF document number but it isn't.\n"\
            "A CPF has the following format XXX.XXX.XXX-XX where X are numbers from 0 to 9.\n"
          )
      end
    end

    context 'when CPF format matches' do
      it 'passes test' do
        expect('123.456.987-12').to a_formatted_cpf
      end
    end
  end

  describe '#be_a_formatted_cpf' do
    context 'when CPF format does not match' do
      it 'fails test' do
        cpf_example = '123.4566.987-12'
        expect { expect(cpf_example).to be_a_formatted_cpf }
          .to fail_with(
            "Was expected `#{cpf_example.inspect}` to be a Brazilian CPF document number but it isn't.\n"\
            "A CPF has the following format XXX.XXX.XXX-XX where X are numbers from 0 to 9.\n"
          )
      end
    end

    context 'when CPF format matches' do
      it 'passes test' do
        expect('123.456.987-12').to be_a_formatted_cpf
      end
    end
  end

  describe '#a_raw_cpf' do
    context 'when CPF format does not match' do
      it 'fails test' do
        cpf_example = '123456698712'
        expect { expect(cpf_example).to a_raw_cpf }
          .to fail_with(
            "Was expected `#{cpf_example.inspect}` to be a raw Brazilian CPF document number but it isn't.\n"\
            "A raw CPF has the following format XXXXXXXXXXX where X are numbers from 0 to 9.\n"
          )
      end
    end

    context 'when CPF format matches' do
      it 'passes test' do
        expect('12345698712').to a_raw_cpf
      end
    end
  end

  describe '#be_a_raw_cpf' do
    context 'when CPF format does not match' do
      it 'fails test' do
        cpf_example = '123456698712'
        expect { expect(cpf_example).to be_a_raw_cpf }
          .to fail_with(
            "Was expected `#{cpf_example.inspect}` to be a raw Brazilian CPF document number but it isn't.\n"\
            "A raw CPF has the following format XXXXXXXXXXX where X are numbers from 0 to 9.\n"
          )
      end
    end

    context 'when CPF format matches' do
      it 'passes test' do
        expect('12345698712').to be_a_raw_cpf
      end
    end
  end
end
