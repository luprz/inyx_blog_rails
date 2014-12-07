require 'test_helper'

module InyxBlogRails
  class AngularControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
