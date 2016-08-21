require "insensitive_search/engine"
require "insensitive_search/engine/filter"

module InsensitiveSearch
  module Engine
    class Base
      # - - - - - - - - - - - - - - - - - -
      # initialize

      def initialize(**options)
        set_options(**options)
      end

      def set_options(
          delimiter: DEFAULT_DELIMITER,
          **options)
        @delimiter = delimiter
        @filter = Filter.new(**options)
      end

      # - - - - - - - - - - - - - - - - - -
      # search

      # Search path with an argument.
      #
      # The return value comes by matching
      # the argument with the objective path insensitively.
      #
      # @param path_source [String] the path for matching insensitively
      # @return [Array<String>] matched and filtered paths
      def search(path_source)
        guard(path_source)
        search_start(path_source)
      end

      # - - - - - - - - - - - - - - - - - -
      # validate

      def guard(object)
        searchable?(object, errorable: true)
      end

      def searchable?(
          object,
          errorable: false)
        if object.kind_of?(String) \
            && object.size > 0
          return true
        end

        if errorable
          fail PathSourceError.new(object)
        end

        false
      end
    end
  end
end