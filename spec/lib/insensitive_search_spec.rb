require 'spec_helper'

describe InsensitiveSearch do
  subject { described_class.run(path_source) }

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

  describe 'VERSION' do
    it 'has a version number' do
      expect(described_class::VERSION).not_to be nil
    end
  end

  describe '.run' do
    context 'when passed an absolute path' do
      context 'where the directory exists' do
        include_context \
            'absolute directory in your system'

        it_behaves_like \
            'to return an instance of Array',
            1
      end

      context 'where the file exists' do
        include_context \
            'absolute file in your system'

        it_behaves_like \
            'to return an instance of Array',
            1
      end
    end

    context 'when passed a relative path of existence' do
      subject { described_class.run(path_source) }

      include_context \
          'relative path in the sample file structure'

      it_behaves_like \
          'to return an instance of Array',
          4
    end

    context 'when passed a nil' do
      subject { described_class.run(nil) }

      it 'raise PathSourceError' do
        expect { subject }.to \
            raise_error(described_class::Engine::PathSourceError)
      end
    end

    context 'when passed a blank string' do
      subject { described_class.run('') }

      it 'raise PathSourceError' do
        expect { subject }.to \
            raise_error(described_class::Engine::PathSourceError)
      end
    end
  end
end