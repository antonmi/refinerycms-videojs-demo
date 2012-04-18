require 'spec_helper'

module Refinery
  module Videos
    describe VideoFile do
      before(:each) do
        file = File.new Refinery.roots(:'refinery/videos').join('spec/support/fixtures/video.flv')
        @video_file = FactoryGirl.create(:video_file, :file => file)
      end

      it 'should be invalid' do
        @video_file.file = nil
        @video_file.should be_invalid
      end

      it 'should be invalid again' do
        @video_file.file = nil
        @video_file.use_external = true
        @video_file.should be_invalid
      end

      it 'should be valid' do
        @video_file.should be_valid
      end

      it 'should be valid again' do
        @video_file.file = nil
        @video_file.use_external = true
        @video_file.external_url = 'file.mp4'
        @video_file.should be_valid
      end

      it 'should return true when file exist' do
        @video_file.exist?.should be_true
      end

      it 'should return false when file does not exist' do
        @video_file.file = nil
        @video_file.exist?.should be_false
      end

    end
  end
end
