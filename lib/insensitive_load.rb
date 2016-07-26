require "insensitive_load/version"
require "insensitive_load/collector"

module InsensitiveLoad
  class << self
    def collector(*args)
      Collector.new(*args)
    end

    def items(*args)
      collector(*args).items
    end

    def dirs(*args)
      collector(*args).dirs
    end

    def files(*args)
      collector(*args).files
    end

    def values(*args)
      collector(*args).values
    end
  end
end
