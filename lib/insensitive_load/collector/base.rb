require "insensitive_load/item"

module InsensitiveLoad
  module Collector
    class Base
      attr_reader \
          :delimiter,
          :items

      # - - - - - - - - - - - - - - - - - -
      # error

      ItemError = Class.new(::ArgumentError) do
        def initialize(object)
          message = 'The passed argument "%s" is not a kind of Item or Array including items.' % object
          super(message)
        end
      end

      PathSourceError = Class.new(::ArgumentError) do
        def initialize(path)
          message = 'The path "%s" is not available.' % path
          super(message)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # initialize

      def initialize(source, **options)
        set_options(**options)

        source.kind_of?(String) \
            ? initialize_by_string(source)
            : add(source)
      end

      # - - - - - - - - - - - - - - - - - -
      # getter

      def pathes
        @items.map(&:path)
      end

      def dirs
        self.class.new(@items.select(&:dir?))
      end

      def files
        self.class.new(@items.select(&:file?))
      end

      def values
        files.items.map(&:value)
      end

      # - - - - - - - - - - - - - - - - - -
      # setter

      def add(item)
        @items ||= []
        @items |= make_item_array(item)
      end

      def set_options(
          delimiter: Collector::DEFAULT_DELIMITER)
        @delimiter = delimiter
      end

      private

      # - - - - - - - - - - - - - - - - - -
      # initialize by string

      def initialize_by_string(path_source)
        validate_path_source(path_source)

        @items = collect(path_source).map do |path|
          Item.new(path)
        end
      end

      def validate_path_source(path_source)
        if path_source.kind_of?(String) \
            && path_source.size > 0
          return true
        end

        fail PathSourceError.new(path_source)
      end

      # - - - - - - - - - - - - - - - - - -
      # make item array

      def make_item_array(item)
        validate_item(item)
        item.kind_of?(Array) ? item : [item]
      end

      def validate_item(object)
        if object.kind_of?(Item)
          return true
        end

        if object.kind_of?(Array) \
            && object[0].kind_of?(Item)
          return true
        end

        fail ItemError.new(object)
      end
    end
  end
end