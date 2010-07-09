require 'test_helper'

class PomodorosControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Pomodoro.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Pomodoro.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Pomodoro.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to pomodoro_url(assigns(:pomodoro))
  end
  
  def test_edit
    get :edit, :id => Pomodoro.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Pomodoro.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Pomodoro.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Pomodoro.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Pomodoro.first
    assert_redirected_to pomodoro_url(assigns(:pomodoro))
  end
  
  def test_destroy
    pomodoro = Pomodoro.first
    delete :destroy, :id => pomodoro
    assert_redirected_to pomodoros_url
    assert !Pomodoro.exists?(pomodoro.id)
  end
end
