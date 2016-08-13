shared_context 'relative path in the sample file structure' do
  before {
    Dir.chdir(File.expand_path('../../sample', __FILE__))
  }

  let(:path_source) { 'ext/soFTwaRe/Config.conf' }
end
