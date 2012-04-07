# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Videos" do
    describe "Admin" do
      describe "videos" do
        login_refinery_user

        describe "videos list" do
          before(:each) do
            FactoryGirl.create(:video, :file_name => "UniqueTitleOne")
            FactoryGirl.create(:video, :file_name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.videos_admin_videos_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.videos_admin_videos_path

            click_link "Add New Video"
          end

          context "valid data" do
            it "should succeed" do
              pending do
                fill_in "File Name", :with => "This is a test of the first string field"
                click_button "Save"

                page.should have_content("'This is a test of the first string field' was successfully added.")
                Refinery::Videos::Video.count.should == 1
              end
            end
          end

          context "invalid data" do
            it "should fail" do
              pending do
                click_button "Save"

                page.should have_content("File Name can't be blank")
                Refinery::Videos::Video.count.should == 0
              end
            end
          end
        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:video, :file_name => "A file_name") }

          it "should succeed" do
            pending do
              visit refinery.videos_admin_videos_path

              within ".actions" do
                click_link "Edit this video"
              end

              fill_in "File Name", :with => "A different file_name"
              click_button "Save"

              page.should have_content("'A different file_name' was successfully updated.")
              page.should have_no_content("A file_name")
            end
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:video, :file_name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.videos_admin_videos_path

            click_link "Remove this video forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Videos::Video.count.should == 0
          end
        end

      end
    end
  end
end
