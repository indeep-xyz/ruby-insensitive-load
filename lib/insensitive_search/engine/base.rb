require "insensitive_search/engine"

module InsensitiveSearch
  module Engine
    class Base
      # - - - - - - - - - - - - - - - - - -
      # initialize

      def initialize(**options)
        set_options(**options)
      end

      def set_options(
          delimiter: DEFAULT_DELIMITER)
        @delimiter = delimiter
      end

      # - - - - - - - - - - - - - - - - - -
      # validate

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