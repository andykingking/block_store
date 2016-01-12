module BlockStore
  class Wrapper
    def initialize(target)
      @target = target
      @store = {}
    end

    def block(method_name)
      @store[method_name]
    end

    def method_missing(method_name, *args, &block)
      @store[method_name] = block
      @target.send(method_name, *args, &block)
    end
  end
end
