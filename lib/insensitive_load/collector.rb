require "insensitive_load/collector/base"

module InsensitiveLoad
  module Collector
    class << self
      def new(*args)
        Base.new(*args)
      end
    end
  end
end