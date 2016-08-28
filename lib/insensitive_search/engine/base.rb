require "insensitive_search/engine"
require "insensitive_search/engine/filter"

module InsensitiveSearch
  module Engine
    class Base
      # - - - - - - - - - - - - - - - - - -
      # initialize

      # Initialize me.
      #
      # @param options [Hash] the keyword-argument passed to the method "set_options"
      def initialize(**options)
        set_options(**options)
      end

      # Set instance variables collectively.
      #
      # @param options [Hash] the keyword-argument for initialization of Filter
      # @option [String] :delimiter the delimiter for path
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

      # Check whether the argument is searchable string.
      #
      # @raise [PathSourceError]
      #   the object is not searchable and option[:errorable] is true
      #
      # @param object [Object] the object which checked to be whether searchable
      # @option [Boolean] :errorable can raise an error when it is true
      # @return [FalseClass] the object is not searchable
      # @return [TrueClass] the object is searchable
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

      private

      # - - - - - - - - - - - - - - - - - -
      # validate

      # Raise error
      # when the parameters are wrong for search.
      #
      # @param object [Object] the object which checked to be whether searchable
      # @return [TrueClass] there are no wrong parameters
      def guard(object)
        searchable?(object, errorable: true)
      end
    end
  end
end