# BraDocuments

[![Build Status](https://travis-ci.com/bvicenzo/bra_documents.svg?branch=master)](https://travis-ci.com/bvicenzo/bra_documents)

This gem make us able to generate Brazilian documents, such as CPF and CNPJ.
We can generate a tottaly random number, or pass the number and the gem completes with the verification digits.
If you already have a CPF or CNPJ only their numbers, you can also put the mask using the formatter.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bra_documents'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bra_documents

## Usage

### CPF Generation

```rb
BraDocuments::CPFGenerator.generate
#=> "86027265892"

BraDocuments::CPFGenerator.generate(formatted: true)
#=> "038.857.544-10"

BraDocuments::CPFGenerator.generate(person_number: '123123123')
#=> "12312312387"

BraDocuments::CPFGenerator.generate(person_number: '123123123', formatted: true)
#=> "123.123.123-87"
```

### CPF digit verification

```rb
BraDocuments::CPFGenerator.valid_verification_digit?(document: '86027265892')
#=> true

BraDocuments::CPFGenerator.valid_verification_digit?(document: '123.123.123-87')
#=> true

BraDocuments::CPFGenerator.valid_verification_digit?(document: '123.123.123-88')
#=> false
```

### CNPJ Generation

```rb
BraDocuments::CNPJGenerator.generate
#=> "62885807804809"

BraDocuments::CNPJGenerator.generate(formatted: true)
#=> "53.855.973/0664-39"

BraDocuments::CNPJGenerator.generate(company_number: '53855973')
#=> "53855973879456"

BraDocuments::CNPJGenerator.generate(company_number: '53855973', formatted: true)
#=> "53.855.973/8189-02"

BraDocuments::CNPJGenerator.generate(company_number: '53855973', matrix_subsidiary_number: '0001')
#=> "53855973000179"

BraDocuments::CNPJGenerator.generate(company_number: '53855973', matrix_subsidiary_number: '0001', formatted: true)
#=> "53.855.973/0001-79"
```

### CNPJ digit verification

```rb
BraDocuments::CNPJGenerator.valid_verification_digit?(document: '62885807804809')
#=> true

BraDocuments::CNPJGenerator.valid_verification_digit?(document: '53.855.973/0001-79')
#=> true

BraDocuments::CNPJGenerator.valid_verification_digit?(document: '53855973000177')
#=> false
```

### Formatting

```rb
BraDocuments::Formatter.format('86027265892', as: :cpf)
# => "860.272.658-92"

BraDocuments::Formatter.format('53855973879456', as: :cnpj)
#=> "53.855.973/8794-56"

BraDocuments::Formatter.raw('53.855.973/8794-56')
#=> "53855973879456"
```

### Matching

```rb
BraDocuments::Matcher.match?('11111111111', kind: :cpf, mode: :raw)
#=> true

BraDocuments::Matcher.match?('11111111111', kind: :cpf, mode: :formatted)
#=> false

BraDocuments::Matcher.match?('11111111111', kind: :cnpj, mode: :raw)
#=> false

BraDocuments::Matcher.match?('90.978.812/0001-07', kind: :cnpj, mode: :formatted)
#=> true
```

### Tests Matching

#### Config
If you use RSpec to test your apps we also provide mathers to make easy test if your field has a CPF with a valid format.

In your `spec/spec_helper.rb` file, require our helpers.

```rb
# spec/spec_helper.rb

require 'bra_documents/testing/rspec'
```

#### Using

```rb
RSpec.describe 'my tests' do
  it 'is a formatted CPF' do
    expect('123.456.789-00').to be_a_formatted_cpf
  end

  it 'receives a formatted CPF' do
    object = double(action: true)

    expect(object).to receive(:action).with(a_formatted_cpf)

    object.action('123.456.789-00')
  end

  it 'is a raw CPF' do
    expect('12345678900').to be_a_raw_cpf
  end

  it 'receives a raw CPF' do
    object = double(action: true)

    expect(object).to receive(:action).with(a_raw_cpf)

    object.action('12345678900')
  end

  it 'is a formatted CNPJ' do
    expect('53.855.973/8794-56').to be_a_formatted_cnpj
  end

  it 'receives a formatted CNPJ' do
    object = double(action: true)

    expect(object).to receive(:action).with(a_formatted_cnpj)

    object.action('53.855.973/8794-56')
  end

  it 'is a raw CNPJ' do
    expect('53855973879456').to be_a_raw_cnpj
  end

  it 'receives a raw CNPJ' do
    object = double(action: true)

    expect(object).to receive(:action).with(a_raw_cnpj)

    object.action('53855973879456')
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bra_documents.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
