require 'spec_helper'

describe InsensitiveLoad do
  it 'has a version number' do
    expect(InsensitiveLoad::VERSION).not_to be nil
  end

  describe '.glob' do
    subject { InsensitiveLoad.glob(path_src) }

    context 'when passed a relative path of existence' do
      before {
        Dir.chdir(File.expand_path('../sample', __FILE__))
      }

      let(:path_src) { 'ext/soFTwaRe/Config.conf' }

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including files' do
        expect(subject.size).to \
            eq(4)
      end

      it 'return an array including relative path' do
        subject.each do |path|
          expect(path.downcase).to \
              eq(path_src.downcase)
        end
      end
    end

    context 'when passed an absolute path of existence' do
      let(:path_src) { '/eTc/HOsTS' }

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including files' do
        expect(subject.size).to \
            eq(1)
      end

      it 'return an array including absolute path' do
        subject.each do |path|
          expect(path.downcase).to \
              eq(path_src.downcase)
        end
      end
    end
  end

  describe '.dirs' do
    subject { InsensitiveLoad.dirs(path_src) }

    context 'when passed a relative path of existence' do
      before {
        Dir.chdir(File.expand_path('../sample', __FILE__))
      }

      let(:path_src) { 'ext/soFTwaRe/Config.conf' }

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including directories' do
        expect(subject.size).to \
            eq(1)
      end

      it 'return an array including relative path' do
        subject.each do |path|
          expect(path.downcase).to \
              eq(path_src.downcase)
        end
      end
    end

    context 'when passed an absolute path of existence' do
      let(:path_src) { '/uSR/Bin' }

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including files' do
        expect(subject.size).to \
            eq(1)
      end

      it 'return an array including absolute path' do
        subject.each do |path|
          expect(path.downcase).to \
              eq(path_src.downcase)
        end
      end
    end
  end

  describe '.files' do
    subject { InsensitiveLoad.files(path_src) }

    context 'when passed a relative path of existence' do
      before {
        Dir.chdir(File.expand_path('../sample', __FILE__))
      }

      let(:path_src) { 'ext/soFTwaRe/Config.conf' }

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including files' do
        expect(subject.size).to \
            eq(3)
      end

      it 'return an array including relative path' do
        subject.each do |path|
          expect(path.downcase).to \
              eq(path_src.downcase)
        end
      end
    end

    context 'when passed an absolute path of existence' do
      let(:path_src) { '/eTc/HOsTS' }

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including files' do
        expect(subject.size).to \
            eq(1)
      end

      it 'return an array including absolute path' do
        subject.each do |path|
          expect(path.downcase).to \
              eq(path_src.downcase)
        end
      end
    end
  end
end
