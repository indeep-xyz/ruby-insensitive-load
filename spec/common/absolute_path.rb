shared_context 'absolute directory in your system' do
  let(:path_source) {
    Gem.win_platform? \
        ? ENV['TEMP'].upcase
        : '/uSR/Bin'
  }
end

shared_context 'absolute file in your system' do
  let(:path_source) {
    Gem.win_platform? \
        ? ENV['ComSpec'].upcase
        : '/eTc/HOsTS'
  }
end
