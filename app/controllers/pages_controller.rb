class PagesController < ApplicationController
  def home
    @latest_games = Game.only_public.latest

    # Enable aggressive caching for home page,
    # for Nginx search docs on proxy_cache directive
    expires_in(1.minute, public: true)
  end
end
