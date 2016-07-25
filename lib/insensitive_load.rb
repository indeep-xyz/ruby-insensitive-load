require "insensitive_load/version"
require "insensitive_load/collector"

module InsensitiveLoad
  class << self
    def collector(*args)
      Collector.new(*args)
    end

    def items(
        *args,
        absolute_path: nil)
      collector(*args).items(absolute_path)
    end

    def dirs(
        *args,
        absolute_path: nil)
      collector(*args).dirs(absolute_path)
    end

    def files(
        *args,
        absolute_path: nil)
      collector(*args).files(absolute_path)
    end

    def values(
        *args)
      collector(*args).values
    end
  end
end
