shared_context 'at directory for testing relative path' do
  before {
    Dir.chdir(File.expand_path('../relative_root', __FILE__))
  }
end

shared_context 'relative path which is found plural things' do
  include_context 'at directory for testing relative path'
  let(:path_source) { 'ext/soFTwaRe/Config.conf' }
end

shared_context 'relative path which is found singular thing' do
  include_context 'at directory for testing relative path'
  let(:path_source) { 'ext/onLY_oNe.tXT' }
end
