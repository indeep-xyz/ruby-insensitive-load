require "insensitive_search/base"

module InsensitiveSearch
  class Windows < Base

    # - - - - - - - - - - - - - - - - - -
    # collect

    def collect(path)
      File.exist?(path) ? [path] : []
    end
  end
 end