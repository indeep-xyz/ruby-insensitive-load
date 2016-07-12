require "insensitive_load/version"
require "insensitive_load/list"

module InsensitiveLoad
  class << self
    def glob(path_src)
      List.glob(path_src)
    end
  end
end
