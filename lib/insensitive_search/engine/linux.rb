require "insensitive_search/engine/base"
require "insensitive_search/in_dir"

module InsensitiveSearch
  module Engine
    class Linux < Base
      private

      # Start insensitive searching.
      #
      # The branch depends on whether
      # the argument as path is absolute or relative.
      #
      # @param [String] path_source the source for searching
      # @return [Array] matched and filtered paths
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

      # List up paths matched insensitively by InDir.
      #
      # @param [String] dir the directory path
      # @param [String] filename the file name
      # @return [Array] matched paths
      def search_in_dir(dir, filename)
        InDir.new(dir).selected_list(filename)
      end
    end
  end
end