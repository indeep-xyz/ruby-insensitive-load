require 'spec_helper'

describe InsensitiveSearch do
  subject { described_class.run(path_source) }

  shared_context 'relative path in the sample file structure' do
    before {
      Dir.chdir(File.expand_path('../../sample', __FILE__))
    }

    let(:path_source) { 'ext/soFTwaRe/Config.conf' }
  end

  shared_examples 'to return an instance of Array' do |size|
    it 'return an array' do
      expect(subject).to \
          be_a_kind_of(Array)
    end

    it 'return an array of proper size' do
      expect(subject.size).to \
          eq(size)
    end
  end

  describe '.run' do
    context 'when passed a relative path of existence' do
      subject { described_class.run(path_source) }

      include_context \
          'relative path in the sample file structure'

      it_behaves_like \
          'to return an instance of Array',
          4
    end
  end
end