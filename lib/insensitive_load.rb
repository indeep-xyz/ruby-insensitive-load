require "insensitive_load/version"
require "insensitive_load/list"

module InsensitiveLoad
  class << self
    def items(*args)
      List.items(*args)
    end

    def dirs(*args)
      List.dirs(*args)
    end

    def files(*args)
      List.files(*args)
    end
  end
end
