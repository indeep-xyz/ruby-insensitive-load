require 'spec_helper'

describe InsensitiveSearch do
  describe 'VERSION' do
    it 'has a version number' do
      expect(described_class::VERSION).not_to be nil
    end
  end

  describe '.new' do
    subject { described_class.new }

    it 'returns a kind of Engine::Base' do
      is_expected.to \
          be_a_kind_of(described_class::Engine::Base)
    end
  end

  describe '.run' do
    subject { described_class.run(path_source) }

    context 'when passed an absolute path' do
      context 'where the directory exists' do
        include_context \
            'absolute path of directory'

        it_behaves_like \
            'to return paths correctly',
            1
      end

      context 'where the file exists' do
        include_context \
            'absolute path of file'

        it_behaves_like \
            'to return paths correctly',
            1
      end
    end

    context 'when passed a relative path' do
      context 'where plural files and directories exist' do
        include_context \
            'relative path which is found plural things'

        it_behaves_like \
            'to return paths correctly',
            4
      end

      context 'where singular thing exists' do
        include_context \
            'relative path which is found singular thing'

        it_behaves_like \
            'to return paths correctly',
            1
      end
    end

    context 'when passed a nil' do
      let(:path_source) { nil }

      it 'raise PathSourceError' do
        expect { subject }.to \
            raise_error(described_class::Engine::PathSourceError)
      end
    end

    context 'when passed a blank string' do
      let(:path_source) { '' }

      it 'raise PathSourceError' do
        expect { subject }.to \
            raise_error(described_class::Engine::PathSourceError)
      end
    end
  end

  describe '.dir' do
    subject { described_class.dir(path_source) }

    context 'when passed an absolute path' do
      context 'where the directory exists' do
        include_context \
            'absolute path of directory'

        it_behaves_like \
            'to return paths correctly',
            1
      end

      context 'where the file exists' do
        include_context \
            'absolute path of file'

        it_behaves_like \
            'to return paths correctly',
            0
      end
    end

    context 'when passed a relative path' do
      context 'where plural files and directories exist' do
        include_context \
            'relative path which is found plural things'

        it_behaves_like \
            'to return paths correctly',
            1
      end

      context 'where a file exists' do
        include_context \
            'relative path which is found singular thing'

        it_behaves_like \
            'to return paths correctly',
            0
      end
    end
  end

  describe '.file' do
    subject { described_class.file(path_source) }

    context 'when passed an absolute path' do
      context 'where the directory exists' do
        include_context \
            'absolute path of directory'

        it_behaves_like \
            'to return paths correctly',
            0
      end

      context 'where the file exists' do
        include_context \
            'absolute path of file'

        it_behaves_like \
            'to return paths correctly',
            1
      end
    end

    context 'when passed a relative path' do
      context 'where plural files and directories exist' do
        include_context \
            'relative path which is found plural things'

        it_behaves_like \
            'to return paths correctly',
            3
      end

      context 'where a file exists' do
        include_context \
            'relative path which is found singular thing'

        it_behaves_like \
            'to return paths correctly',
            1
      end
    end
  end
end