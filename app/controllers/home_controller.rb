class HomeController < ApplicationController
  def index
     @properties = Property.approved.limit(6)
  end
end
