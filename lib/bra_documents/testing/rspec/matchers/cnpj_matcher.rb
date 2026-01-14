# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :a_formatted_cnpj do
  match { |cnpj| BraDocuments::Matcher.match?(cnpj.to_s, kind: :cnpj, mode: :formatted) }

  failure_message do |cnpj|
    "Was expected `#{cnpj.inspect}` to be a Brazilian CNPJ document number but it isn't.\n"\
      "A CNPJ has the following format AA.AAA.AAA/AAAA-99 where X are numbers from 0 to 9.\n"
  end
end

RSpec::Matchers.define :a_raw_cnpj do
  match { |cnpj| BraDocuments::Matcher.match?(cnpj.to_s, kind: :cnpj, mode: :raw) }

  failure_message do |cnpj|
    "Was expected `#{cnpj.inspect}` to be a raw Brazilian cnpj document number but it isn't.\n"\
      "A raw CNPJ has the following format AAAAAAAAAAAAAA where X are numbers from 0 to 9.\n"
  end
end

RSpec::Matchers.alias_matcher :be_a_formatted_cnpj, :a_formatted_cnpj
RSpec::Matchers.alias_matcher :be_a_raw_cnpj, :a_raw_cnpj
