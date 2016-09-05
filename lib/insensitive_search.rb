require "insensitive_search/engine/linux"
require "insensitive_search/engine/windows"

module InsensitiveSearch
  class << self
    def new(**options)
      Gem.win_platform? \
          ? Engine::Windows.new(**options)
          : Engine::Linux.new(**options)
    end

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

    def searchable?(*args)
      Engine::Base.allocate.searchable?(*args)
    end
  end
end