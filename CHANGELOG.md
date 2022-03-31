
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.2] - 2020-22-10

### Fixed

- CPFGenerator.valid_verification_digit? returning false if document does not have CPF format;
- CNPJGenerator.valid_verification_digit? returning false if document does not have CNPJ format;

## [1.0.1] - 2020-22-10

### Added

- Add Formatter.raw method to make a document number to have only numbers;
- Add Matcher.match? to check if a CPF or CNPJ has a valid format;
- Add CPFGenerator.valid_verification_digit? to check if a CPF has a valid verification digit
- Add CNPJGenerator.valid_verification_digit? to check if a CNPJ has a valid verification digit

## [1.0.0] - 2020-22-10

### Added

- CPF and CNPJ number formatter;
- CPF number generator;
- CNPJ number generator;
- RSpec CPF matcher helpers;
- RSpec CNPJ matcher helpers;
