require "insensitive_search/engine/base"

module InsensitiveSearch
  module Engine
    class Windows < Base
      private

      def search_start(path)
        File.exist?(path) \
            && @filter.ok?(path) ? [path] : []
      end
    end
  end
 end