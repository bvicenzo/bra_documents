# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :a_formatted_cpf do
  match do |cpf|
    formatted_cpf_pattern = /\A(\d{3}\.\d{3}\.\d{3})-(\d{2})\z/

    formatted_cpf_pattern.match?(cpf.to_s)
  end

  failure_message do |cpf|
    "Was expected `#{cpf.inspect}` to be a Brazilian CPF document number but it isn't.\n"\
      "A CPF has the following format XXX.XXX.XXX-XX where X are numbers from 0 to 9.\n"
  end
end

RSpec::Matchers.define :a_raw_cpf do
  match do |cpf|
    raw_cpf_pattern = /\A\d{11}\z/

    raw_cpf_pattern.match?(cpf.to_s)
  end

  failure_message do |cpf|
    "Was expected `#{cpf.inspect}` to be a raw Brazilian CPF document number but it isn't.\n"\
      "A raw CPF has the following format XXXXXXXXXXX where X are numbers from 0 to 9.\n"
  end
end

RSpec::Matchers.alias_matcher :be_a_formatted_cpf, :a_formatted_cpf
RSpec::Matchers.alias_matcher :be_a_raw_cpf, :a_raw_cpf
