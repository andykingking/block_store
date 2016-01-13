# Block store

Stores blocks.

## Usage

Add to your `Gemfile`:

    gem 'block_store'

Add to your `spec_helper`:

    require 'block_store/rspec_helpers'

Create a spy from an existing object:

    subject = [1, 2, 3]
    subject_spy = block_store(subject)
    subject_spy.each do { |number| puts number }
    subject_spy.block(:each).call('This gets printed')

## Testing

    rake
