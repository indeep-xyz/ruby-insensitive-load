module InsensitiveSearch
  class PathFilter

    # Initialize me.
    #
    # @option [Boolean] :directory if true, accept directory path at validation.
    # @option [Boolean] :file if true, accept file path at validation.
    def initialize(
        directory: true,
        file: true)
      @directory = directory
      @file = file
    end

    # - - - - - - - - - - - - - - - - - -
    # validate

    # Check whether the path passes through my filter.
    #
    # @option path [String] the path
    # @return [TrueClass] the argument is passed
    # @return [FalseClass] the argument is failed
    def ok?(path)
      @directory && @file \
          || valid_directory?(path) \
          || valid_file?(path)
    end

    def ng?(path)
      !ok?(path)
    end

    private

    def valid_directory?(path)
      @directory \
          && File.directory?(path)
    end

    def valid_file?(path)
      @file \
          && File.file?(path)
    end
  end
end