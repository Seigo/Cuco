require 'test_helper'

class TodoDaysControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => TodoDay.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    TodoDay.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    TodoDay.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to todo_day_url(assigns(:todo_day))
  end
  
  def test_edit
    get :edit, :id => TodoDay.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    TodoDay.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TodoDay.first
    assert_template 'edit'
  end
  
  def test_update_valid
    TodoDay.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TodoDay.first
    assert_redirected_to todo_day_url(assigns(:todo_day))
  end
  
  def test_destroy
    todo_day = TodoDay.first
    delete :destroy, :id => todo_day
    assert_redirected_to todo_days_url
    assert !TodoDay.exists?(todo_day.id)
  end
end
