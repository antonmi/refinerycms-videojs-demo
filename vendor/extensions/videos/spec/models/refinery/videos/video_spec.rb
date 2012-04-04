require 'spec_helper'

module Refinery
  module Videos
    describe Video do
      describe "validations" do
        subject do
          FactoryGirl.create(:video,
          :file_name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:file_name) { should == "Refinery CMS" }
      end
    end
  end
end
