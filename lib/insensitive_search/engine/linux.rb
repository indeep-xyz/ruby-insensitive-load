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

      # Search recursively.
      #
      # @note the processing flow
      #   1-1. Start the first loop with the arguments, ['path', 'to', 'filename'], ''.
      #   1-2. Call itself with the arguments, ['to', 'filename'], 'path'.
      #   2-1. Start with the arguments from 1-2.
      #   2-2. Call itself with the arguments, ['filename'], 'path/to'.
      #   3-1. Start with the arguments from 2-2.
      #   3-2. Add path to the return value if the path 'path/to/filename' is found insensitively and passed through the filter.
      #   3-3. Return value.
      #   2-3. Return the value from 3-3.
      #   1-3. Return the value from 2-3.
      #
      # @param [Array] parts the path split by directory separator on Linux.
      # @param [String] prefix the prefix of path
      # @return [Array] matched and filtered paths
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