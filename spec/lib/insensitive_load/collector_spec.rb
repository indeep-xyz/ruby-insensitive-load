require 'spec_helper'

describe InsensitiveLoad::Collector do
  describe '.items' do
    subject { InsensitiveLoad.items(path_src) }

    context 'when passed a relative path of existence' do
      before {
        Dir.chdir(File.expand_path('../../../sample', __FILE__))
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

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including files' do
        expect(subject.size).to \
            eq(1)
      end

      context 'without "absolute_path" option' do
        it 'return an array including absolute path' do
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
            expect(path.downcase).to \
                eq(path_src.downcase)
          end
        end
      end
    end
  end

  describe '.dirs' do
    subject { InsensitiveLoad.dirs(path_src) }

    context 'when passed a relative path of existence' do
      before {
        Dir.chdir(File.expand_path('../../../sample', __FILE__))
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

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including files' do
        expect(subject.size).to \
            eq(1)
      end

      context 'without "absolute_path" option' do
        it 'return an array including absolute path' do
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
            expect(path.downcase).to \
                eq(path_src.downcase)
          end
        end
      end
    end
  end

  describe '.files' do
    subject { InsensitiveLoad.files(path_src) }

    context 'when passed a relative path of existence' do
      before {
        Dir.chdir(File.expand_path('../../../sample', __FILE__))
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

      it 'return an array' do
        expect(subject).to \
            be_a_kind_of(Array)
      end

      it 'return an array including files' do
        expect(subject.size).to \
            eq(1)
      end

      context 'without "absolute_path" option' do
        it 'return an array including absolute path' do
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
            expect(path.downcase).to \
                eq(path_src.downcase)
          end
        end
      end
    end
  end
end