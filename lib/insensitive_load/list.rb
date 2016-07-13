
module InsensitiveLoad
  class List
    class << self
      def all(path_src)
        allocate.all(path_src)
      end

      def dirs(*args)
        allocate.dirs(*args)
      end

      def files(*args)
        allocate.files(*args)
      end
    end

    def all(path_src)
      Gem.win_platform? \
          ? collect_in_windows(path_src)
          : collect_in_linux(path_src)
    end

    def dirs(path_src)
      if not validate_path(path_src)
        return []
      end

      all(path_src).select do |path|
        File.directory?(path)
      end
    end

    def files(path_src)
      if not validate_path(path_src)
        return []
      end

      all(path_src).select do |path|
        File.file?(path)
      end
    end

    private

    def validate_path(path_src)
      if not path_src.kind_of?(String) \
          || path_src.size < 1
        return false
      end

      true
    end

    def collect_in_linux(path_src, delimiter: '/')
      parts = path_src.split(delimiter)

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