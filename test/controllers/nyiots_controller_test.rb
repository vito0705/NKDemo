require 'test_helper'

class NyiotsControllerTest < ActionDispatch::IntegrationTest
  test "should get nymap" do
    get nyiots_nymap_url
    assert_response :success
  end

end
