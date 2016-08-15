
module InsensitiveSearch
  class InDir
    attr_reader \
        :dir

    # - - - - - - - - - - - - - - - - - -
    # initializem, set

    def initialize(dir)
      @dir = dir
    end

    # - - - - - - - - - - - - - - - - - -
    # list paths in @dir

    def list
      if @dir.size > 0
        if File.directory?(@dir)
          dir = @dir.sub(/\/*$/, '/')
          Dir.glob("#{dir}*")
        else
          []
        end
      else
        Dir.glob('*')
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