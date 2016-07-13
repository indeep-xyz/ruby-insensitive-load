require "insensitive_load/version"
require "insensitive_load/list"

module InsensitiveLoad
  class << self
    def all(path_src)
      List.all(path_src)
    end

    def dirs(*args)
      List.dirs(*args)
    end

    def files(*args)
      List.files(*args)
    end
  end
end
