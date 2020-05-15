require "application_system_test_case"

class OhayosTest < ApplicationSystemTestCase
  setup do
    @ohayo = ohayos(:one)
  end

  test "visiting the index" do
    visit ohayos_url
    assert_selector "h1", text: "Ohayos"
  end

  test "creating a Ohayo" do
    visit ohayos_url
    click_on "New Ohayo"

    click_on "Create Ohayo"

    assert_text "Ohayo was successfully created"
    click_on "Back"
  end

  test "updating a Ohayo" do
    visit ohayos_url
    click_on "Edit", match: :first

    click_on "Update Ohayo"

    assert_text "Ohayo was successfully updated"
    click_on "Back"
  end

  test "destroying a Ohayo" do
    visit ohayos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ohayo was successfully destroyed"
  end
end
