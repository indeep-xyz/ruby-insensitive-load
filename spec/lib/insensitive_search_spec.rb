require 'spec_helper'

describe InsensitiveSearch do
  subject { described_class.run(path_source) }

  describe 'VERSION' do
    it 'has a version number' do
      expect(described_class::VERSION).not_to be nil
    end
  end

  describe '.run' do
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
        subject { described_class.run(path_source) }

        include_context \
            'relative path which is found plural things'

        it_behaves_like \
            'to return paths correctly',
            4
      end

      context 'where singular thing exists' do
        subject { described_class.run(path_source) }

        include_context \
            'relative path which is found singular thing'

        it_behaves_like \
            'to return paths correctly',
            1
      end
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