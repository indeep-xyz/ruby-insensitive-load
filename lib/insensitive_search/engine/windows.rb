require "insensitive_search/engine/base"

module InsensitiveSearch
  module Engine
    class Windows < Base

      # - - - - - - - - - - - - - - - - - -
      # search

      def search(path)
        guard(path_source)

        File.exist?(path) \
            && @filter.ok?(path) ? [path] : []
      end
    end
  end
 end