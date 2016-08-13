require "insensitive_search/base"
require "insensitive_search/linux"
require "insensitive_search/windows"

module InsensitiveSearch
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

  class << self
    def run(*args)
      Base.run(*args)
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