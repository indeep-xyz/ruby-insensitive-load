require "insensitive_load/item"

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

      def initialize(path_source, **options)
        if not validate_path(path_source)
          fail PathError.new(path_source)
        end

        set_options(**options)
        @items = collect(path_source).map do |path|
          Item.new(path)
        end
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