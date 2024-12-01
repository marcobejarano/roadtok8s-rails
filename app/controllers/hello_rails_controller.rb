class HelloRailsController < ApplicationController
  def index
    render json: { "Hello": "Ruby on Rails 8" }
  end
end
