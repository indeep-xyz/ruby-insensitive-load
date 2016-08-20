require "insensitive_search/engine/base"

module InsensitiveSearch
  module Engine
    class Windows < Base
      private

      # Start searching.
      #
      # The return value has been just
      # checked existence at the argument path
      # and filtered.
      # On the Windows environment,
      # its way of resolving path is insensitive.
      #
      # @param [String] path the path
      # @return [Array] matched and filtered paths
      def search_start(path)
        File.exist?(path) \
            && @filter.ok?(path) ? [path] : []
      end
    end
  end
 end