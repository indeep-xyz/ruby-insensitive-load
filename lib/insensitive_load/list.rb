
module InsensitiveLoad
  class List
    attr_reader :delimiter
    DEFAULT_DELIMITER = Gem.win_platform? ? '\\' : '/'

    class << self
      def all(*args, **options)
        new(**options).all(*args)
      end

      def dirs(*args, **options)
        new(**options).dirs(*args)
      end

      def files(*args, **options)
        new(**options).files(*args)
      end
    end

    # - - - - - - - - - - - - - - - - - -
    # initialize

    def initialize(
        delimiter: DEFAULT_DELIMITER)
      @delimiter = delimiter
    end

    # - - - - - - - - - - - - - - - - - -
    # list

    def all(*args)
      if not validate_path(*args)
        return []
      end

      Gem.win_platform? \
          ? collect_in_windows(*args)
          : collect_in_linux(*args)
    end

    def dirs(*args)
      all(*args).select do |path|
        File.directory?(path)
      end
    end

    def files(*args)
      all(*args).select do |path|
        File.file?(path)
      end
    end

    private

    # - - - - - - - - - - - - - - - - - -
    # validate for listing

    def validate_path(path_src)
      if not path_src.kind_of?(String) \
          || path_src.size < 1
        return false
      end

      true
    end

    # - - - - - - - - - - - - - - - - - -
    # collect

    def collect_in_linux(path_src)
      parts = path_src.split(@delimiter)

      parts[0] == '' \
          ? collect_loop(parts[1..-1], '/')
          : collect_loop(parts)
    end

    def collect_in_windows(path)
      File.exist?(path) ? [path] : []
    end

    def collect_loop(parts, prefix = '')
      result = []

      Dir.glob("#{prefix}*").select do |path|
        if path.downcase == prefix.downcase + parts[0].downcase
          if parts.size > 1
            result |= collect_loop(parts[1..-1], path + "/")
          elsif parts.size < 2
            result.push(path)
          end
        end
      end

      result
    end
  end
end