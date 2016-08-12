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
          message = 'The passed argument "%s" (%s) is not a kind of Item or Array including items.' % [
              object,
              object.class.name]
          super(message)
        end
      end

      PathSourceError = Class.new(::ArgumentError) do
        def initialize(object)
          message = 'The path "%s" (%s) is not available.' % [
              object,
              object.class.name]
          super(message)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # initialize

      def initialize(source, **options)
        set_options(**options)
        add(source)
      end

      # - - - - - - - - - - - - - - - - - -
      # get parameters in @items

      def pathes
        @items.map(&:path)
      end

      def values
        files.items.map(&:value)
      end

      # - - - - - - - - - - - - - - - - - -
      # get items from @items

      def dirs
        self.class.new(@items.select(&:dir?))
      end

      def files
        self.class.new(@items.select(&:file?))
      end

      # - - - - - - - - - - - - - - - - - -
      # setter

      def add(source)
        source.kind_of?(String) \
            ? add_by_path(source)
            : add_item(source)
      end

      def add_by_path(path_source)
        validate_path_source(path_source)

        @items = collect(path_source).map do |path|
          Item.new(path)
        end
      end

      def add_item(item)
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

      def validate_path_source(object)
        if object.kind_of?(String) \
            && object.size > 0
          return true
        end

        fail PathSourceError.new(object)
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