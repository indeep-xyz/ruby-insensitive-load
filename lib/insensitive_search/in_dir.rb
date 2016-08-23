
module InsensitiveSearch
  class InDir
    attr_reader \
        :dir

    # - - - - - - - - - - - - - - - - - -
    # initialize, set

    def initialize(dir)
      self.dir = dir
    end

    def dir=(dir)
      @dir = optimize_dir(dir)
    end

    # - - - - - - - - - - - - - - - - - -
    # list paths in @dir

    def list
      if @dir.nil?
        []
      else
        Dir.glob("#{@dir}*")
      end
    end

    def selected_list(filename)
      objective_path = create_objective_path(filename)

      list.select do |path|
        insensitive_match?(path, objective_path)
      end
    end

    private

    # Optimize the directory path for @dir.

    # @param dir [Object] the object
    # @return [String] the object is an available directory path or an empty string
    # @return [NilClass] the object is unsuitable to @dir
    def optimize_dir(dir)
      if dir.kind_of?(String)
        if dir == ''
          return ''
        elsif File.directory?(dir)
          return dir.sub(/\/*$/, '/')
        end
      end

      nil
    end

    # Create a path for matching.
    #
    # @param filename [String] the filename
    # @return [String] a path derived from filename and @dir
    # @return [NilClass] when @dir is nil
    def create_objective_path(filename)
       if @dir.nil?
         nil
       elsif @dir == ''
         filename
       else
         File.join(@dir, filename)
       end
    end

    def insensitive_match?(a, b)
      a.downcase == b.downcase
    end
  end
end