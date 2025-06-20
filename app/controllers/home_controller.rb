class HomeController < ApplicationController
  def index
    # アカウント取得
    account = Oidc.find_by(issuer: current_user['issuer'], sub: current_user['sub']).account

    # bookmarks を View に渡す
    @bookmarks = account.bookmark
  end

  def add_my_bookmark
    # アカウント取得
    account = Oidc.find_by(issuer: current_user['issuer'], sub: current_user['sub']).account

    # ページの存在確認
    @new_page = Page.find_by({url: params[:url]})

    # ページが存在していなければ新しいページを作成
    if @page.nil?
      @new_page = Page.create({"url": params[:url]})
    end

    # アカウントに紐づくページを追加
    account_pages = account.page
    account_pages.append @new_page

    # bookmarks を View に渡す
    @bookmarks = account.bookmark

    redirect_to action: 'index'
  end
end
