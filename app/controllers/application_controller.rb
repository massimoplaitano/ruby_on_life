class ApplicationController < ActionController::Base
  def after_sign_in_path_for(user)
    games_path
  end
end
