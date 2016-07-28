module InsensitiveLoad
  class Item
    attr_reader :path

    def initialize(path)
      @path = ::File.expand_path(path)
    end

    def value
      ::File.read(@path)
    end

    def dir?
      ::File.directory?(@path)
    end

    def file?
      ::File.file?(@path)
    end

    private

    def method_missing(method_name, *args, &block)
      @path.send(method_name, *args, &block)
    end
  end
end