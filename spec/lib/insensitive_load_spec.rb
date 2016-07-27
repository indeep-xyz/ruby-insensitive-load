require 'spec_helper'

describe InsensitiveLoad do
  it 'has a version number' do
    expect(InsensitiveLoad::VERSION).not_to be nil
  end

  describe '.collector' do
    subject { described_class.collector(path_source) }

    context 'when passed a path source' do
      let(:path_source) { 'path/to/something' }

      it 'return an instance of a kind of Collector::Base' do
        is_expected.to \
            be_a_kind_of(described_class::Collector::Base)
      end
    end
  end

  describe '.values' do
    subject { described_class.values(path_source) }

    context 'when passed a path source' do
      let(:path_source) { 'path/to/something' }

      it 'return an instance of a kind of Array' do
        is_expected.to \
            be_a_kind_of(Array)
      end
    end
  end

  describe 'methods to get pathes' do
    shared_examples 'to use the same name method in Collector' do |method_name|
      subject { described_class.send(method_name, path_source) }
      let(:path_source) { 'PATH/TO/UNREASONABLE_' + [].__id__.to_s }

      context 'when passed a unreasonable path source' do
        it 'return an instance of Array' do
          expect(subject).to \
              be_a_kind_of(Array)
        end
      end
    end

    describe '.pathes' do
      it_behaves_like \
          'to use the same name method in Collector',
          :pathes
    end

    describe '.dirs' do
      it_behaves_like \
          'to use the same name method in Collector',
          :dirs
    end

    describe '.files' do
      it_behaves_like \
          'to use the same name method in Collector',
          :files
    end
  end
end
