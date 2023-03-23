class Webhooks::BaseController < ApplicationController
  # protect_from_forgery except: :webhook

  def webhook; end
end
