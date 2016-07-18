require 'spec_helper'

describe InsensitiveLoad::Collector do
  let(:instance) { described_class.new(path_src) }

  shared_context 'at root of the sample file structure' do
    before {
      Dir.chdir(File.expand_path('../../../sample', __FILE__))
    }
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

  shared_examples 'return path equal insensitively the path source' do |method_name|
    let(:returner) { instance.send(method_name).map(&:downcase) }

    it 'return the equivalent insensitively' do
      expect(returner).to \
          all(eq(path_src.downcase))
    end
  end

  shared_examples 'initialized by absolute path' do |method_name|
    context 'without "absolute_path" option' do
      it_behaves_like \
          'return path equal insensitively the path source',
          method_name
    end

    context 'with "absolute_path" option' do
      let(:returner) { instance.send(method_name) }
      let(:returner_absoluted) { instance.send(method_name, true) }

      it 'return an array including absolute path' do
        expect(returner_absoluted).to \
            eq(returner)
      end
    end
  end

  describe '.items' do
    subject { InsensitiveLoad.items(path_src) }

    context 'when passed a relative path of existence' do
      let(:path_src) { 'ext/soFTwaRe/Config.conf' }

      include_context \
          'at root of the sample file structure'

      it_behaves_like \
          'to return an instance of Array',
          4

      context 'without "absolute_path" option' do
        it 'return an array including relative path' do
          subject.each do |path|
            expect(path.downcase).to \
                eq(path_src.downcase)
          end
        end
      end

      context 'with "absolute_path" option' do
        subject {
          InsensitiveLoad.items(
              path_src,
              absolute_path: true)
        }

        it 'return an array including absolute path' do
          subject.each do |path|
            matched_head = path.downcase.index(path_src.downcase)
            expect(matched_head).to \
                be > 1
          end
        end
      end

      context 'with unreasonable "delimiter" option' do
        subject {
          InsensitiveLoad.items(
              path_src,
              delimiter: 'DELIMITER_STRING')
        }

        it 'return an empty array' do
          expect(subject.size).to \
              eq(0)
        end
      end
    end

    context 'when passed an absolute path of existence' do
      let(:path_src) { '/eTc/HOsTS' }

      it_behaves_like \
          'to return an instance of Array',
          1

      it_behaves_like \
          'initialized by absolute path',
          :items
    end
  end

  describe '.dirs' do
    subject { InsensitiveLoad.dirs(path_src) }

    context 'when passed a relative path of existence' do
      let(:path_src) { 'ext/soFTwaRe/Config.conf' }

      include_context \
          'at root of the sample file structure'

      it_behaves_like \
          'to return an instance of Array',
          1

      context 'without "absolute_path" option' do
        it 'return an array including relative path' do
          subject.each do |path|
            expect(path.downcase).to \
                eq(path_src.downcase)
          end
        end
      end

      context 'with "absolute_path" option' do
        subject {
          InsensitiveLoad.dirs(
              path_src,
              absolute_path: true)
        }

        it 'return an array including absolute path' do
          subject.each do |path|
            matched_head = path.downcase.index(path_src.downcase)
            expect(matched_head).to \
                be > 1
          end
        end
      end

      context 'with unreasonable "delimiter" option' do
        subject {
          InsensitiveLoad.dirs(
              path_src,
              delimiter: 'DELIMITER_STRING')
        }

        it 'return an empty array' do
          expect(subject.size).to \
              eq(0)
        end
      end
    end

    context 'when passed an absolute path of existence' do
      let(:path_src) { '/uSR/Bin' }

      it_behaves_like \
          'to return an instance of Array',
          1

      it_behaves_like \
          'initialized by absolute path',
          :dirs
    end
  end

  describe '.files' do
    subject { InsensitiveLoad.files(path_src) }

    context 'when passed a relative path of existence' do
      let(:path_src) { 'ext/soFTwaRe/Config.conf' }

      include_context \
          'at root of the sample file structure'

      it_behaves_like \
          'to return an instance of Array',
          3

      context 'without "absolute_path" option' do
        it 'return an array including relative path' do
          subject.each do |path|
            expect(path.downcase).to \
                eq(path_src.downcase)
          end
        end
      end

      context 'with "absolute_path" option' do
        subject {
          InsensitiveLoad.files(
              path_src,
              absolute_path: true)
        }

        it 'return an array including absolute path' do
          subject.each do |path|
            matched_head = path.downcase.index(path_src.downcase)
            expect(matched_head).to \
                be > 1
          end
        end
      end

      context 'with unreasonable "delimiter" option' do
        subject {
          InsensitiveLoad.files(
              path_src,
              delimiter: 'DELIMITER_STRING')
        }

        it 'return an empty array' do
          expect(subject.size).to \
              eq(0)
        end
      end
    end

    context 'when passed an absolute path of existence' do
      let(:path_src) { '/eTc/HOsTS' }

      it_behaves_like \
          'to return an instance of Array',
          1

      it_behaves_like \
          'initialized by absolute path',
          :files
    end
  end
end