require "insensitive_load/search/base"

module InsensitiveLoad
  module Search
    class Windows < Base

      # - - - - - - - - - - - - - - - - - -
      # collect

      def collect(path)
        File.exist?(path) ? [path] : []
      end
    end
  end
end