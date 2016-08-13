shared_context 'absolute path of directory' do
  let(:path_source) {
    Gem.win_platform? \
        ? ENV['TEMP'].upcase
        : '/uSR/Bin'
  }
end

shared_context 'absolute path of file' do
  let(:path_source) {
    Gem.win_platform? \
        ? ENV['ComSpec'].upcase
        : '/eTc/HOsTS'
  }
end
