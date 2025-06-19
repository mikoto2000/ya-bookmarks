require "application_system_test_case"

class OidcsTest < ApplicationSystemTestCase
  setup do
    @oidc = oidcs(:one)
  end

  test "visiting the index" do
    visit oidcs_url
    assert_selector "h1", text: "Oidcs"
  end

  test "should create oidc" do
    visit oidcs_url
    click_on "New oidc"

    fill_in "Account", with: @oidc.account_id
    fill_in "Issuer", with: @oidc.issuer
    fill_in "Sub", with: @oidc.sub
    click_on "Create Oidc"

    assert_text "Oidc was successfully created"
    click_on "Back"
  end

  test "should update Oidc" do
    visit oidc_url(@oidc)
    click_on "Edit this oidc", match: :first

    fill_in "Account", with: @oidc.account_id
    fill_in "Issuer", with: @oidc.issuer
    fill_in "Sub", with: @oidc.sub
    click_on "Update Oidc"

    assert_text "Oidc was successfully updated"
    click_on "Back"
  end

  test "should destroy Oidc" do
    visit oidc_url(@oidc)
    click_on "Destroy this oidc", match: :first

    assert_text "Oidc was successfully destroyed"
  end
end
