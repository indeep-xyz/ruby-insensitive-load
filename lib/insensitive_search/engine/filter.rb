module InsensitiveSearch
  module Engine
    class Filter
      def initialize(
          directory: true,
          file: true)
        @directory = directory
        @file = file
      end

      # - - - - - - - - - - - - - - - - - -
      # validate

      def ok?(path)
        @directory && @file \
            || valid_directory?(path) \
            || valid_file?(path)
      end

      def ng?(path)
        !ok?(path)
      end

      private

      def valid_directory?(path)
        @directory \
            && File.directory?(path)
      end

      def valid_file?(path)
        @file \
            && File.file?(path)
      end
    end
  end
end