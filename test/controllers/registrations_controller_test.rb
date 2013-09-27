require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Registration.count') do
      post :create, registration: { semester_no: @registration.semester_no, student_id_card_no: @registration.student_id_card_no, student_name: @registration.student_name, subject_no_1: @registration.subject_no_1, subject_no_2: @registration.subject_no_2, subject_no_3: @registration.subject_no_3, subject_no_4: @registration.subject_no_4 }
    end

    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should show registration" do
    get :show, id: @registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @registration
    assert_response :success
  end

  test "should update registration" do
    patch :update, id: @registration, registration: { semester_no: @registration.semester_no, student_id_card_no: @registration.student_id_card_no, student_name: @registration.student_name, subject_no_1: @registration.subject_no_1, subject_no_2: @registration.subject_no_2, subject_no_3: @registration.subject_no_3, subject_no_4: @registration.subject_no_4 }
    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should destroy registration" do
    assert_difference('Registration.count', -1) do
      delete :destroy, id: @registration
    end

    assert_redirected_to registrations_path
  end
end
