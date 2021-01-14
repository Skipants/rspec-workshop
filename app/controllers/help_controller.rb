class HelpController < ApplicationController
  def show
    # You'll be adding a constraint here. If it fails, call the following:
    # head :not_found

    render json: { solution: "Have you tried turning it on and off again?" }
  end
end
