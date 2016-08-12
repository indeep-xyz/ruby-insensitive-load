require "insensitive_load/item"
require "insensitive_load/search"

module InsensitiveLoad
  class Collector
    attr_reader \
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

    def initialize(source, **search_options)
      @search_options = search_options
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

      @items = search(path_source).map do |path|
        Item.new(path)
      end
    end

    def add_item(item)
      @items ||= []
      @items |= make_item_array(item)
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

    # - - - - - - - - - - - - - - - - - -
    # search

    def search(*args)
      ::InsensitiveLoad::Search.run(*args, **@search_options)
    end

    # - - - - - - - - - - - - - - - - - -
    # validate

    def validate_item(object)
      unless check_item(object)
        fail ItemError.new(object)
      end
    end

    def validate_path_source(object)
      Search.searchable?(object, errorable: true)
    end

    def validate_source(object)
      if !check_item(object) \
          && !Search.searchable?(object)
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