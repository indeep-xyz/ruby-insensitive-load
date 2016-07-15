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

    def items(*args)
      collector = Collector.new(*args)
      collector.items
    end

    def dirs(*args)
      collector = Collector.new(*args)
      collector.dirs
    end

    def files(*args)
      collector = Collector.new(*args)
      collector.files
    end
  end
end