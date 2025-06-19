require "test_helper"

class OidcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @oidc = oidcs(:one)
  end

  test "should get index" do
    get oidcs_url
    assert_response :success
  end

  test "should get index find by id" do
    get oidcs_url, params: { q: { id_eq: @oidc.id } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr:nth-of-type(1) > td", text: @oidc.id.to_s
  end
  test "should get index search issuer" do
    search_string = @oidc.issuer
    get oidcs_url, params: { q: { issuer_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: search_string # one
  end

  test "should get index search issuer, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get oidcs_url, params: { q: { issuer_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: oidcs(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: oidcs(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(2)", text: oidcs(:destroy_target).name # destroy_target
  end
  test "should get index search sub" do
    search_string = @oidc.sub
    get oidcs_url, params: { q: { sub_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: search_string # one
  end

  test "should get index search sub, multi hit" do
    search_string = "o" # `o`ne, tw`o`, destr`o`y_target.
    get oidcs_url, params: { q: { sub_cont: search_string } }
    assert_response :success

    assert_select "table > tbody > tr", count: 3
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: oidcs(:one).name # one
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: oidcs(:two).name # two
    assert_select "table > tbody > tr > td:nth-of-type(3)", text: oidcs(:destroy_target).name # destroy_target
  end
  test "should get index search accounts" do
    search_ids = [oidcs(:one).account, oidcs(:two).account]
    get oidcs_url, params: { q: { account_id_in: search_ids } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: @oidc.account.name # one
    assert_select "table > tbody > tr > td:nth-of-type(4)", text: @oidc.account.name # two
  end

  test "should get index search created_at single hit" do
    target_datetime = @oidc.created_at
    get oidcs_url, params: { q: {
      created_at_gteq: target_datetime,
      created_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime) # one
  end

  test "should get index search created_at, multi hit" do
    target_datetime_from = oidcs(:one).created_at
    target_datetime_to = oidcs(:two).created_at
    get oidcs_url, params: { q: {
      created_at_gteq: target_datetime_from,
      created_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(5)", text: I18n.l(target_datetime_to) # two
  end

  test "should get index search updated_at" do
    target_datetime = @oidc.updated_at
    get oidcs_url, params: { q: {
      updated_at_gteq: target_datetime,
      updated_at_lteq_end_of_minute: target_datetime
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 1
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime) # one
  end

  test "should get index search updated_at, multi hit" do
    target_datetime_from = oidcs(:one).updated_at
    target_datetime_to = oidcs(:two).updated_at
    get oidcs_url, params: { q: {
      updated_at_gteq: target_datetime_from,
      updated_at_lteq_end_of_minute: target_datetime_to
    } }
    assert_response :success

    assert_select "table > tbody > tr", count: 2
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime_from) # one
    assert_select "table > tbody > tr > td:nth-of-type(6)", text: I18n.l(target_datetime_to) # two
  end

  test "should get new" do
    get new_oidc_url
    assert_response :success
  end

  test "should create oidc" do
    assert_difference("Oidc.count") do
      post oidcs_url, params: { oidc:
        { account_id: @oidc.account_id, issuer: @oidc.issuer, sub: @oidc.sub } }
    end

    assert_redirected_to oidc_url(Oidc.last)
  end

  test "should show oidc" do
    get oidc_url(@oidc)
    assert_response :success
  end

  test "should get edit" do
    get edit_oidc_url(@oidc)
    assert_response :success
  end

  test "should update oidc" do
    patch oidc_url(@oidc), params: { oidc:
      { account_id: @oidc.account_id, issuer: @oidc.issuer, sub: @oidc.sub } }
    assert_redirected_to oidc_url(@oidc)
  end

  test "should destroy oidc" do
    oidc = oidcs(:destroy_target)
    assert_difference("Oidc.count", -1) do
      delete oidc_url(oidc)
    end

    assert_redirected_to oidcs_url
  end
end
