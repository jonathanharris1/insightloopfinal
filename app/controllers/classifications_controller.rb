class ClassificationsController < ApplicationController

  def index
    @classifications = Classification.all
  end

  def show
    @classification = Classification.find(params[:id])
  end
end
