require "insensitive_load/collector/base"

module InsensitiveLoad
  module Collector
    class Windows < Base

      # - - - - - - - - - - - - - - - - - -
      # collect

      def collect(path)
        File.exist?(path) ? [path] : []
      end
    end
  end
end