require 'spec_helper'

describe InsensitiveLoad do
  it 'has a version number' do
    expect(InsensitiveLoad::VERSION).not_to be nil
  end

  describe '.collector' do
    subject { described_class.collector(path_source) }

    context 'when passed a path source' do
      let(:path_source) { 'path/to/something' }

      it 'return an instance of a kind of Collector' do
        is_expected.to \
            be_a_kind_of(described_class::Collector)
      end
    end
  end

  describe 'methods which pass through to instance method of Collector' do
    shared_context 'Collector mocks' do
      let(:collector_module) { described_class::Collector }
      let(:collector_method_mock) { double('Collector method') }
      let(:collector_module_mock) { class_double(collector_module_mock) }

      before do
        allow(collector_module).to \
            receive(:new).
            and_return(collector_method_mock)
      end
    end

    shared_examples 'Collector method' do |method_name|
      subject { described_class.send(method_name, nil) }
      include_context 'Collector mocks'

      it 'pass to Collector#pathes' do
        allow(collector_method_mock).to \
            receive(method_name)

        expect(subject).to \
            eq(nil)
      end
    end

    describe '.pathes' do
      it_behaves_like 'Collector method', :pathes
    end

    describe '.dirs' do
      it_behaves_like 'Collector method', :dirs
    end

    describe '.files' do
      it_behaves_like 'Collector method', :files
    end

    describe '.values' do
      it_behaves_like 'Collector method', :values
    end
  end
end
