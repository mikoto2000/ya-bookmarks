class HomeController < ApplicationController

  def index
    if current_user
      @pages = Oidc.find_by(issuer: current_user['issuer'], sub: current_user['sub']).account.page
    else
      @pages = []
    end
  end
end
