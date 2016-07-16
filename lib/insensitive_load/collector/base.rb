module InsensitiveLoad
  module Collector
    class Base
      attr_reader \
          :delimiter

      # - - - - - - - - - - - - - - - - - -
      # error

      PathError = Class.new(::ArgumentError) do
        def initialize(path)
          message = 'The path "%s" is not available.' % path
          super(message)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # initialize

      def initialize(path_src, **options)
        if not validate_path(path_src)
          fail PathError.new(path_src)
        end

        set_options(**options)
        @collection = collect(path_src)
      end

      # - - - - - - - - - - - - - - - - - -
      # getter

      def items(absolute_path = false)
        (absolute_path) \
            ? absolute_items
            : @collection
      end

      def dirs
        @collection.select do |path|
          File.directory?(path)
        end
      end

      def files
        @collection.select do |path|
          File.file?(path)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # setter

      def set_options(
          delimiter: Collector::DEFAULT_DELIMITER)
        @delimiter = delimiter
      end

      private

      # - - - - - - - - - - - - - - - - - -
      # getter

      def absolute_items
        @collection.map do |path|
          File.expand_path(path)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # validate

      def validate_path(path_src)
        if not path_src.kind_of?(String) \
            || path_src.size < 1
          return false
        end

        true
      end
    end
  end
end