require "insensitive_search/engine/base"
require "insensitive_search/in_dir"

module InsensitiveSearch
  module Engine
    class Linux < Base
      # - - - - - - - - - - - - - - - - - -
      # search

      def search(path_source)
        guard(path_source)
        search_start(path_source)
      end

      private

      # Start insensitive searching on Linux.
      #
      # The branch depends on whether
      # the argument as path is absolute or relative.
      #
      # @param [String] path_source the source for searching
      # @return [Array] search result
      def search_start(path_source)
        parts = path_source.split(@delimiter)
        parts[0] == '' \
            ? search_loop(parts[1..-1], '/')
            : search_loop(parts)
      end

      def search_loop(parts, prefix = '')
        list = search_in_dir(prefix, parts[0])

        list.inject([]) do |result, path|
          if parts.size > 1
            result |= search_loop(parts[1..-1], path)
          elsif @filter.ok?(path)
            result.push(path)
          end

          result
        end
      end

      def search_in_dir(dir, filename)
        InDir.new(dir).selected_list(filename)
      end
    end
  end
end