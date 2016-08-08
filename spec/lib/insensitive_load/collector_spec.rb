require 'spec_helper'

describe InsensitiveLoad::Collector do
  let(:instance) { described_class.new(path_source) }

  shared_context 'relative path in the sample file structure' do
    before {
      Dir.chdir(File.expand_path('../../../sample', __FILE__))
    }

    let(:path_source) { 'ext/soFTwaRe/Config.conf' }
  end

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

  describe '.new' do
    context 'when passed a relative path of existence' do
      subject { described_class.new(path_source) }

      include_context \
          'relative path in the sample file structure'

      it 'create a kind of InsensitiveLoad::Collector::Base' do
        is_expected.to \
            be_a_kind_of(described_class::Base)
      end
    end

    context 'when passed an instance of InsensitiveLoad::Item' do
      let(:item) { InsensitiveLoad::Item.allocate }
      subject { described_class.new(item) }

      it 'create a kind of InsensitiveLoad::Collector::Base' do
        is_expected.to \
            be_a_kind_of(described_class::Base)
      end
    end

    context 'when passed an array including Item instances' do
        let(:item1) { InsensitiveLoad::Item.allocate }
        let(:item2) { InsensitiveLoad::Item.allocate }
        subject { described_class.new([item1, item2]) }

      it 'create a kind of InsensitiveLoad::Collector::Base' do
        is_expected.to \
            be_a_kind_of(described_class::Base)
      end
    end
  end

  describe 'methods to add @items' do
    describe '#add' do
      let(:instance) { described_class::Base.allocate }

      context 'when passed an instance of InsensitiveLoad::Item' do
        let(:item) { InsensitiveLoad::Item.allocate }
        subject { instance.add(item) }

        it 'add @items correctly' do
          is_expected.to \
              all(be_an_instance_of(InsensitiveLoad::Item))
        end
      end

      context 'when passed an Array including Item instances' do
        let(:item1) { InsensitiveLoad::Item.allocate }
        let(:item2) { InsensitiveLoad::Item.allocate }
        subject { instance.add([item1, item2]) }

        it 'add @items correctly' do
          is_expected.to \
              all(be_an_instance_of(InsensitiveLoad::Item))
        end

        it 'be correct size of the added @items' do
          expect(subject.size).to \
              eq(2)
        end
      end

      context 'when passed a nil' do
        subject { instance.add(nil) }

        it 'raise ItemError' do
          expect { subject }.to \
              raise_error(described_class::Base::ItemError)
        end
      end
    end
  end

  describe 'methods to get @items' do
    describe '#items' do
      subject { instance.items }

      context 'when passed a relative path of existence' do
        include_context \
            'relative path in the sample file structure'

        it_behaves_like \
            'to return an instance of Array',
            4

        it 'return Array filled with instances of InsensitiveLoad::Item' do
          is_expected.to \
              all(be_an_instance_of(InsensitiveLoad::Item))
        end
      end
    end
  end

  describe 'methods to get data in @items' do
    describe '#values' do
      subject { instance.values }

      context 'when passed a relative path of existence' do
        include_context \
            'relative path in the sample file structure'

        it_behaves_like \
            'to return an instance of Array',
            3

        it 'return the text in files' do
          is_expected.to \
              all(match(/\AI am '[^']+'.\z*/))
        end
      end
    end
  end

  describe 'methods to get path in @items' do
    shared_examples 'initialized by absolute path' do |method_name|
      let(:returner) { instance.send(method_name).map(&:downcase) }

      it 'return the equivalent insensitively' do
        expect(returner).to \
            all(eq(path_source.downcase))
      end
    end

    shared_examples 'initialized by relative path' do |method_name|
      let(:returner) { instance.send(method_name) }

      it 'return an array including absolute path' do
        returner.each do |path|
          matched_head = path.downcase.index(path_source.downcase)
          expect(matched_head).to \
              be > 1
        end
      end
    end

    describe '#pathes' do
      subject { instance.pathes }

      context 'when passed an absolute path of existence' do
        include_context \
            'absolute file in your system'

        it_behaves_like \
            'to return an instance of Array',
            1

        it_behaves_like \
            'initialized by absolute path',
            :pathes
      end

      context 'when passed a relative path of existence' do
        include_context \
            'relative path in the sample file structure'

        it_behaves_like \
            'to return an instance of Array',
            4

        it_behaves_like \
            'initialized by relative path',
            :pathes

        context 'with unreasonable "delimiter" option' do
          let(:instance) {
            described_class.new(
                path_source,
                delimiter: 'DELIMITER_STRING')
          }

          it 'return an empty array' do
            expect(subject.size).to \
                eq(0)
          end
        end
      end
    end
  end

  describe 'returns a kind of Collector' do
    shared_examples 'initialized by absolute path' do |method_name|
      let(:returner) { instance.send(method_name).pathes.map(&:downcase) }

      it 'return the equivalent insensitively' do
        expect(returner).to \
            all(eq(path_source.downcase))
      end
    end

    shared_examples 'initialized by relative path' do |method_name|
      let(:returner) { instance.send(method_name).pathes }

      it 'return an array including absolute path' do
        returner.each do |path|
          matched_head = path.downcase.index(path_source.downcase)
          expect(matched_head).to \
              be > 1
        end
      end
    end

    shared_examples 'to return a kind of Collector' do |size|
      it 'return a kind of Collector' do
        expect(subject).to \
            be_a_kind_of(InsensitiveLoad::Collector::Base)
      end

      it 'return an array of proper size' do
        expect(subject.items.size).to \
            eq(size)
      end
    end

    describe '#dirs' do
      subject { instance.dirs }

      context 'when passed an absolute path of existence' do
        include_context \
            'absolute directory in your system'

        it_behaves_like \
            'to return a kind of Collector',
            1

        it_behaves_like \
            'initialized by absolute path',
            :dirs
      end

      context 'when passed a relative path of existence' do
        include_context \
            'relative path in the sample file structure'

        it_behaves_like \
            'to return a kind of Collector',
            1

        it_behaves_like \
            'initialized by relative path',
            :dirs
      end
    end

    describe '#files' do
      subject { instance.files }

      context 'when passed an absolute path of existence' do
        include_context \
            'absolute file in your system'

        it_behaves_like \
            'to return a kind of Collector',
            1

        it_behaves_like \
            'initialized by absolute path',
            :files
      end

      context 'when passed a relative path of existence' do
        include_context \
            'relative path in the sample file structure'

        it_behaves_like \
            'to return a kind of Collector',
            3

        it_behaves_like \
            'initialized by relative path',
            :files
      end
    end
  end
end