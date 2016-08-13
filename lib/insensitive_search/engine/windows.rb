require "insensitive_search/engine/base"

module InsensitiveSearch
  module Engine
    class Windows < Base

      # - - - - - - - - - - - - - - - - - -
      # search

      def search(path)
        guard(path_source)
        File.exist?(path) ? [path] : []
      end
    end
  end
 end