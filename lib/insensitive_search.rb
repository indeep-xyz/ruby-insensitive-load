require "insensitive_search/engine/linux"
require "insensitive_search/engine/windows"

module InsensitiveSearch
  class << self
    def new(**options)
      Gem.win_platform? \
          ? Engine::Windows.new(**options)
          : Engine::Linux.new(**options)
    end

    # Search directory paths.
    #
    # Some parameters of the keyword-argument are
    # overwrited by this method.
    #
    # @param *args [argument-list] options for searching
    # @param **options [keyword-argument] options for creating an engine
    # @see  #run
    def dir(*args, **options)
      options[:directory] = true
      options[:file] = false

      run(*args, **options)
    end

    def file(*args, **options)
      options[:directory] = false
      options[:file] = true

      run(*args, **options)
    end

    # Run searching.
    #
    # @param *args [argument-list] options for searching
    # @param **options [keyword-argument] options for creating an engine
    # @see #new
    # @see Engine::Base#search
    def run(*args, **options)
      new(**options).search(*args)
    end

    # Check whether the argument is seachable string.
    #
    # @param *args [argument-list] object for checking
    # @return [FalseClass] the object is not searchable
    # @return [TrueClass] the object is searchable
    # @see Engine::Base#searchable?
    def searchable?(*args)
      Engine::Base.allocate.searchable?(*args)
    end
  end
end