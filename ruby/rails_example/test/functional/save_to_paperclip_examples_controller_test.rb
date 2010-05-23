require 'test_helper'

class SaveToPaperclipExamplesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:save_to_paperclip_examples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create save_to_paperclip_example" do
    assert_difference('SaveToPaperclipExample.count') do
      post :create, :save_to_paperclip_example => { }
    end

    assert_redirected_to save_to_paperclip_example_path(assigns(:save_to_paperclip_example))
  end

  test "should show save_to_paperclip_example" do
    get :show, :id => save_to_paperclip_examples(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => save_to_paperclip_examples(:one).to_param
    assert_response :success
  end

  test "should update save_to_paperclip_example" do
    put :update, :id => save_to_paperclip_examples(:one).to_param, :save_to_paperclip_example => { }
    assert_redirected_to save_to_paperclip_example_path(assigns(:save_to_paperclip_example))
  end

  test "should destroy save_to_paperclip_example" do
    assert_difference('SaveToPaperclipExample.count', -1) do
      delete :destroy, :id => save_to_paperclip_examples(:one).to_param
    end

    assert_redirected_to save_to_paperclip_examples_path
  end
end
