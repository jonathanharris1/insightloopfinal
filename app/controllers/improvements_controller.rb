class ImprovementsController < ApplicationController

  def show
    @improvement = Improvement.find(params[:id])
  end

  def index
    @improvements = Improvement.all
  end

  def create
    @improvement = Improvement.new(params[:improvement])
    @improvement.save # Will raise ActiveModel::ForbiddenAttributesError
  end

end





