
module InsensitiveLoad
  class List
    class << self
      def glob(path_src)
        allocate.glob(path_src)
      end

      def files(*args)
        allocate.files(*args)
      end
    end

    def glob(path_src)
      Gem.win_platform? \
          ? glob_in_windows(path_src)
          : glob_in_linux(path_src)
    end

    def files(path_src)
      if not validate_path(path_src)
        return []
      end

      Gem.win_platform? \
          ? files_in_windows(path_src)
          : files_in_linux(path_src)
    end

    private

    def validate_path(path_src)
      if not path_src.kind_of?(String) \
          || path_src.size < 1
        return false
      end

      true
    end

    def glob_in_linux(path_src, delimiter: '/')
      parts = path_src.split(delimiter)

      parts[0] == '' \
          ? glob_loop(parts[1..-1], '/')
          : glob_loop(parts)
    end

    def glob_in_windows(path)
      File.exist?(path) ? [path] : []
    end

    def glob_loop(parts, prefix = '')
      result = []

      Dir.glob("#{prefix}*").select do |path|
        if path.downcase == prefix.downcase + parts[0].downcase
          if parts.size > 1
            result |= glob_loop(parts[1..-1], path + "/")
          elsif parts.size < 2
            result.push(path)
          end
        end
      end

      result
    end

    def files_in_linux(path_src)
      glob(path_src).select do |path|
        File.file?(path)
      end
    end

    def files_in_windows(path)
      File.file?(path) \
          ? [path]
          : []
    end
  end
end