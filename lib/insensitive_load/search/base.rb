module InsensitiveLoad
  module Search
    class Base
      class << self
        def run(*args, **options)
          Gem.win_platform? \
              ? Windows.new(**options).collect(*args)
              : Linux.new(**options).collect(*args)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # initialize

      def initialize(**options)
        set_options(**options)
      end

      def set_options(
          delimiter: DEFAULT_DELIMITER)
        @delimiter = delimiter
      end
    end
  end
end