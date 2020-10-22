# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :a_formatted_cnpj do
  match do |cnpj|
    formatted_cnpj_pattern = /\A(\d{2}\.\d{3}\.\d{3}\/\d{4})-(\d{2})\z/

    formatted_cnpj_pattern.match?(cnpj.to_s)
  end

  failure_message do |cnpj|
    "Was expected `#{cnpj.inspect}` to be a Brazilian CNPJ document number but it isn't.\n"\
      "A CNPJ has the following format XX.XXX.XXX/XXXX-XX where X are numbers from 0 to 9.\n"
  end
end

RSpec::Matchers.define :a_raw_cnpj do
  match do |cnpj|
    raw_cnpj_pattern = /\A\d{14}\z/

    raw_cnpj_pattern.match?(cnpj.to_s)
  end

  failure_message do |cnpj|
    "Was expected `#{cnpj.inspect}` to be a raw Brazilian cnpj document number but it isn't.\n"\
      "A raw CNPJ has the following format XXXXXXXXXXXXXX where X are numbers from 0 to 9.\n"
  end
end

RSpec::Matchers.alias_matcher :be_a_formatted_cnpj, :a_formatted_cnpj
RSpec::Matchers.alias_matcher :be_a_raw_cnpj, :a_raw_cnpj
