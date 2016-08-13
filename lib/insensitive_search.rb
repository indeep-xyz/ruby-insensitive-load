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

    def run(*args, **options)
      new(**options).search(*args)
    end

    def searchable?(*args)
      Engine::Base.allocate.searchable?(*args)
    end
  end
end