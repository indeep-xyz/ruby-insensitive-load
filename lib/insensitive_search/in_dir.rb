
module InsensitiveSearch

  # List file paths in directory.
  # Some methods work in insensitive.
  #
  # @author indeep-xyz
  # @attr_reader dir [String] the directory path for existence
  class InDir
    attr_reader \
        :dir

    # - - - - - - - - - - - - - - - - - -
    # initialize, set

    # Initialize me.
    #
    # @param dir [String] the directory path for existence
    # @return [InDir] an instance
    def initialize(dir)
      self.dir = dir
    end

    # Assign a directory path to @dir.
    # The path is optimized by another method.
    #
    # @param dir [String] the directory path for existence
    # @return [String] @dir
    # @return [NilClass] @dir (the argument is unsuitable)
    def dir=(dir)
      @dir = optimize_dir(dir)
    end

    # - - - - - - - - - - - - - - - - - -
    # list paths in @dir

    # List up file paths in @dir.
    #
    # @return [Array<String>] paths found in @dir
    def list
      if @dir.nil?
        []
      else
        Dir.glob("#{@dir}*")
      end
    end

    # Select paths matched insensitively
    # from the listed paths by the method "list".
    # The string for matching is prepared by
    # joining @dir and the argument.
    #
    # @param filename [String] the filename
    # @return [Array<String>] paths found and selected
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

    # Check whether the arguments
    # are the same string in insensitive.
    #
    # @param a [String] the object for comparison
    # @param b [String] the object for comparison
    # @return [FalseClass] not matched
    # @return [TrueClass] matched
    def insensitive_match?(a, b)
      a.downcase == b.downcase
    end
  end
end