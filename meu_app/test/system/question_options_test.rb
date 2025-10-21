require "application_system_test_case"

class QuestionOptionsTest < ApplicationSystemTestCase
  setup do
    @question_option = question_options(:one)
  end

  test "visiting the index" do
    visit question_options_url
    assert_selector "h1", text: "Question options"
  end

  test "should create question option" do
    visit question_options_url
    click_on "New question option"

    check "Is correct" if @question_option.is_correct
    fill_in "Question", with: @question_option.question_id
    fill_in "Title", with: @question_option.title
    click_on "Create Question option"

    assert_text "Question option was successfully created"
    click_on "Back"
  end

  test "should update Question option" do
    visit question_option_url(@question_option)
    click_on "Edit this question option", match: :first

    check "Is correct" if @question_option.is_correct
    fill_in "Question", with: @question_option.question_id
    fill_in "Title", with: @question_option.title
    click_on "Update Question option"

    assert_text "Question option was successfully updated"
    click_on "Back"
  end

  test "should destroy Question option" do
    visit question_option_url(@question_option)
    accept_confirm { click_on "Destroy this question option", match: :first }

    assert_text "Question option was successfully destroyed"
  end
end
