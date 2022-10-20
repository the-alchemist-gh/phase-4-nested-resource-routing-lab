class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_item_not_found_response

  def index
    items = Item.all
    render json: items, include: :user
  end

  def show
    items = Item.find(params[:id])
    render json: items
  end

  def create
    new_item = Item.create(user_params)
    render json: new_item, status: :created
  end

  
  private

  def render_item_not_found_response
    render json: { error: "Item not found" }, status: :not_found
  end

  def user_params
    params.permit(:id, :name,:description, :price, :user_id)
  end

end
