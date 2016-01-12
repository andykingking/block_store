require 'block_store'

module BlockStore
  module RSpecHelpers
    def block_store(target)
      Wrapper.new(target)
    end
  end
end

RSpec.configure do |config|
  config.include BlockStore::RSpecHelpers
end
