class HomeController < ApplicationController
  def index
    if current_user
      @pages = Oidc.find_by(issuer: current_user['issuer'], sub: current_user['sub']).account.page
    else
      @pages = []
    end
    @new_page = Page.new
  end

  def add_my_bookmark
    @new_page = Page.create({"url": params[:url]})
    pages = Oidc.find_by(issuer: current_user['issuer'], sub: current_user['sub']).account.page
    pages.append @new_page
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to action: 'index' }
    end
  end
end
