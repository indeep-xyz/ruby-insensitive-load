module InsensitiveSearch
  module Engine
    DEFAULT_DELIMITER = Gem.win_platform? ? '\\' : '/'

    # - - - - - - - - - - - - - - - - - -
    # error

    PathSourceError = Class.new(::ArgumentError) do
      def initialize(object)
        message = 'The path "%s" (%s) is not available.' % [
            object,
            object.class.name]
        super(message)
      end
    end
  end
end
