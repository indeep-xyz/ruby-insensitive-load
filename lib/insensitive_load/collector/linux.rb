require "insensitive_load/collector/base"

module InsensitiveLoad
  module Collector
    class Linux < Base
      # - - - - - - - - - - - - - - - - - -
      # error

      DirectoryPathError = Class.new(::ArgumentError) do
        def initialize(dir_path)
          message = 'The directory path "%s" does not exist.' % dir_path
          super(message)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # collect

      def collect(path_source)
        parts = path_source.split(@delimiter)

        parts[0] == '' \
            ? collect_loop(parts[1..-1], '/')
            : collect_loop(parts)
      end

      private

      def collect_loop(parts, prefix = '')
        objective_path = join_path(prefix, parts[0])

        in_dir(prefix).inject([]) do |result, path|
          if not insensitive_match?(path, objective_path)
            next result
          end

          if parts.size > 1
            result |= collect_loop(parts[1..-1], path)
          else
            result.push(path)
          end

          result
        end
      end

      def in_dir(dir_path)
        if dir_path.size > 0
          if not File.directory?(dir_path)
            fail DirectoryPathError.new(dir_path)
          end

          dir_path = "#{dir_path}/".sub(/\/+$/, '/')
        end

        Dir.glob("#{dir_path}*")
      end

      def insensitive_match?(a, b)
        a.downcase == b.downcase
      end

      def join_path(prefix, addition)
        prefix.size < 1 \
            ? addition
            : File.join(prefix, addition)
      end
    end
  end
end