require "insensitive_load/version"
require "insensitive_load/collector"

module InsensitiveLoad
  class << self
    def items(
        path_src,
        absolute_path: nil,
        **init_options)
      collector = Collector.new(path_src, **init_options)
      collector.items(absolute_path)
    end

    def dirs(
        path_src,
        absolute_path: nil,
        **init_options)
      collector = Collector.new(path_src, **init_options)
      collector.dirs(absolute_path)
    end

    def files(
        path_src,
        absolute_path: nil,
        **init_options)
      collector = Collector.new(path_src, **init_options)
      collector.files(absolute_path)
    end
  end
end
