class PingsController < ApplicationController
  def create
    # Here's your starting point:
    # Ping.create(name: params[:name])

    # You'll be adding constraints to this method. If they fail, call the following:
    # head :not_found

    head :ok
  end
end
