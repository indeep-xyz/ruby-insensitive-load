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

      SourceError = Class.new(::ArgumentError) do
        def initialize(object)
          message = 'The source "%s" (%s) is not available.' % [
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
      # add @items

      def add(source)
        validate_source(source)

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

      # - - - - - - - - - - - - - - - - - -
      # set something

      def set_options(
          delimiter: Collector::DEFAULT_DELIMITER)
        @delimiter = delimiter
      end

      private

      # - - - - - - - - - - - - - - - - - -
      # check

      def check_item(object)
        if object.kind_of?(Item)
          return true
        end

        if object.kind_of?(Array) \
            && object[0].kind_of?(Item)
          return true
        end

        false
      end

      def check_path_source(object)
        if object.kind_of?(String) \
            && object.size > 0
          return true
        end

        false
      end

      # - - - - - - - - - - - - - - - - - -
      # validate

      def validate_item(object)
        unless check_item(object)
          fail ItemError.new(object)
        end
      end

      def validate_path_source(object)
        unless check_path_source(object)
          fail PathSourceError.new(object)
        end
      end

      def validate_source(object)
        if !check_item(object) \
            && !check_path_source(object)
          fail SourceError.new(object)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # make something

      def make_item_array(item)
        validate_item(item)
        item.kind_of?(Array) ? item : [item]
      end
    end
  end
end