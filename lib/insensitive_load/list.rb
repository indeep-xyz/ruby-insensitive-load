require "insensitive_load/collector"

module InsensitiveLoad
  class List
    class << self
      def items(*args, **options)
        allocate.items(*args, **options)
      end

      def dirs(*args, **options)
        allocate.dirs(*args, **options)
      end

      def files(*args, **options)
        allocate.files(*args, **options)
      end
    end

    # - - - - - - - - - - - - - - - - - -
    # list

    def items(
        path_src,
        absolute_path: nil,
        **init_options)
      collector = Collector.new(path_src, **init_options)
      collector.items(absolute_path)
    end

    def dirs(
        *args,
        absolute_path: nil,
        **init_options)
      collector = Collector.new(*args, **init_options)
      collector.dirs(absolute_path)
    end

    def files(
        *args,
        absolute_path: nil,
        **init_options)
      collector = Collector.new(*args, **init_options)
      collector.files(absolute_path)
    end
  end
end