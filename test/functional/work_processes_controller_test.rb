require 'test_helper'

class WorkProcessesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_processes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_process" do
    assert_difference('WorkProcess.count') do
      post :create, :work_process => { }
    end

    assert_redirected_to work_process_path(assigns(:work_process))
  end

  test "should show work_process" do
    get :show, :id => work_processes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => work_processes(:one).to_param
    assert_response :success
  end

  test "should update work_process" do
    put :update, :id => work_processes(:one).to_param, :work_process => { }
    assert_redirected_to work_process_path(assigns(:work_process))
  end

  test "should destroy work_process" do
    assert_difference('WorkProcess.count', -1) do
      delete :destroy, :id => work_processes(:one).to_param
    end

    assert_redirected_to work_processes_path
  end
end
