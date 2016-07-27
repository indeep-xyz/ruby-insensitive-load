module InsensitiveLoad
  module Collector
    class Base
      attr_reader \
          :delimiter

      # - - - - - - - - - - - - - - - - - -
      # error

      PathError = Class.new(::ArgumentError) do
        def initialize(path)
          message = 'The path "%s" is not available.' % path
          super(message)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # initialize

      def initialize(path_source, **options)
        if not validate_path(path_source)
          fail PathError.new(path_source)
        end

        set_options(**options)
        @collection = collect(path_source).map do |path|
          File.expand_path(path)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # getter

      def pathes
        @collection
      end

      def dirs
        pathes.select do |path|
          File.directory?(path)
        end
      end

      def files
        pathes.select do |path|
          File.file?(path)
        end
      end

      def values
        files.map do |path|
          File.read(path)
        end
      end

      # - - - - - - - - - - - - - - - - - -
      # setter

      def set_options(
          delimiter: Collector::DEFAULT_DELIMITER)
        @delimiter = delimiter
      end

      private

      # - - - - - - - - - - - - - - - - - -
      # getter

      # - - - - - - - - - - - - - - - - - -
      # validate

      def validate_path(path_source)
        if not path_source.kind_of?(String) \
            || path_source.size < 1
          return false
        end

        true
      end
    end
  end
end