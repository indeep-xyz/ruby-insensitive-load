require 'spec_helper'

describe InsensitiveLoad do
  it 'has a version number' do
    expect(InsensitiveLoad::VERSION).not_to be nil
  end

  describe 'methods to get pathes' do
    shared_examples 'to use the same name method in Collector' do |method_name|
      subject { described_class.send(method_name, path_src) }
      let(:path_src) { 'PATH/TO/UNREASONABLE_' + [].__id__.to_s }

      context 'when passed a unreasonable path source' do
        it 'return an instance of Array' do
          expect(subject).to \
              be_a_kind_of(Array)
        end
      end
    end

    describe '.items' do
      it_behaves_like \
          'to use the same name method in Collector',
          :items
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
