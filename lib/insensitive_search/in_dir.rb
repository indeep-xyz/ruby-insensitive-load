
module InsensitiveSearch
  class InDir
    attr_reader \
        :dir

    # - - - - - - - - - - - - - - - - - -
    # initialize

    def initialize(dir)
      @dir = dir
    end

    # - - - - - - - - - - - - - - - - - -
    # list paths in @dir

    def list
      if @dir == ''
        Dir.glob('*')
      else
        if File.directory?(@dir)
          dir = @dir.sub(/\/*$/, '/')
          Dir.glob("#{dir}*")
        else
          []
        end
      end
    end

    def selected_list(filename)
      objective_path = create_objective_path(filename)

      list.select do |path|
        insensitive_match?(path, objective_path)
      end
    end

    private

    def create_objective_path(filename)
      @dir.size < 1 \
          ? filename
          : File.join(@dir, filename)
    end

    def insensitive_match?(a, b)
      a.downcase == b.downcase
    end
  end
end