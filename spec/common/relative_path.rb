shared_context 'relative path which is found plural things' do
  before {
    Dir.chdir(File.expand_path('../relative_root', __FILE__))
  }

  let(:path_source) { 'ext/soFTwaRe/Config.conf' }
end
