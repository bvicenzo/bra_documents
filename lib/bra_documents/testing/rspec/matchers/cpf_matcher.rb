# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :a_formatted_cpf do
  match { |cpf| BraDocuments::Matcher.match?(cpf.to_s, kind: :cpf, mode: :formatted) }

  failure_message do |cpf|
    "Was expected `#{cpf.inspect}` to be a Brazilian CPF document number but it isn't.\n"\
      "A CPF has the following format 999.999.999-99 where X are numbers from 0 to 9.\n"
  end
end

RSpec::Matchers.define :a_raw_cpf do
  match { |cpf| BraDocuments::Matcher.match?(cpf.to_s, kind: :cpf, mode: :raw) }

  failure_message do |cpf|
    "Was expected `#{cpf.inspect}` to be a raw Brazilian CPF document number but it isn't.\n"\
      "A raw CPF has the following format XXXXXXXXXXX where X are numbers from 0 to 9.\n"
  end
end

RSpec::Matchers.alias_matcher :be_a_formatted_cpf, :a_formatted_cpf
RSpec::Matchers.alias_matcher :be_a_raw_cpf, :a_raw_cpf
