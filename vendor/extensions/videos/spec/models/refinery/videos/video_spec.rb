require 'spec_helper'

module Refinery
  module Videos
    describe Video do
      describe "validations" do
        subject { Video.new }
        before { subject.valid? } # to fill in errors

        it { should be_invalid }
        its(:errors) { should include(:file_name) }
        its(:errors) { should include(:file) }
      end
      describe 'config' do
        let(:video) { Video.new }
        context "get option" do
          before { video.config = { :height => 100 } }
          it "should return config option" do
            video.height.should == video.config[:height]
          end
        end
        context "set option" do
          before { video.config = { :height => 100 } }
          it "should change config option" do
            expect { video.height = 200 }.to change { video.config[:height] }.from(100).to(200)
          end
        end
      end
    end
  end
end
