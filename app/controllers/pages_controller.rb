class PagesController < ApplicationController
  def home
    @latest_games = Game.only_public.latest
    expires_in(1.hour, public: true)
  end
end
