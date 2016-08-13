require 'spec_helper'

describe InsensitiveSearch do
  subject { described_class.run(path_source) }

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
            'absolute path of directory'

        it_behaves_like \
            'to return an instance of Array',
            1
      end

      context 'where the file exists' do
        include_context \
            'absolute path of file'

        it_behaves_like \
            'to return an instance of Array',
            1
      end
    end

    context 'when passed a relative path' do
      context 'where plural files and directories exist' do
        subject { described_class.run(path_source) }

        include_context \
            'relative path which is found plural things'

        it_behaves_like \
            'to return an instance of Array',
            4
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