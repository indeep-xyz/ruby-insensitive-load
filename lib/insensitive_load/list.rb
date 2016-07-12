
module InsensitiveLoad
  class List
    class << self
      def glob(path_src)
        allocate.glob(path_src)
      end
    end

    def glob(path_src)
      delimiter = (Gem.win_platform?) ? '\\' : '/'
      parts = path_src.split(delimiter)

      parts[0] == '' \
          ? glob_loop(parts[1..-1], '/')
          : glob_loop(parts)
    end

    private

    def validate_path(path_src)
      if not path_src.kind_of?(String) \
          || path_src.size < 1
        return false
      end

      true
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
  end
end