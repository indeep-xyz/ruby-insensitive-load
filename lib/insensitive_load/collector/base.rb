require "insensitive_load/item"

module InsensitiveLoad
  module Collector
    class Base
      attr_reader \
          :delimiter,
          :items

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

      def initialize(source, **options)
        set_options(**options)
        initialize_by_string(source)
      end

      # - - - - - - - - - - - - - - - - - -
      # getter

      def pathes
        @items.map(&:path)
      end

      def dirs
        @items.select(&:dir?)
      end

      def files
        @items.select(&:file?)
      end

      def values
        files.map(&:value)
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

      # - - - - - - - - - - - - - - - - - -
      # initialize

      def initialize_by_string(path_source)
        if not validate_path(path_source)
          fail PathError.new(path_source)
        end

        @items = collect(path_source).map do |path|
          Item.new(path)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # validate

      def validate_path(path_source)
        if not path_source.kind_of?(String) \
            || path_source.size < 1
          return false
        end

        true
      end
    end
  end
end