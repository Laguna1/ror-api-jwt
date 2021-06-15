class ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]
  before_action :authorize!

  def index
    @items = current_user.items.all

    render json: serializer.new(@items)
  end

  def show
    render json: serializer.new(@item)
  end

  def create
    items = current_user.items
    
    @item = items.build(item_params)
    if items.exists?(day: item_params[:day])
      render json: { day: ['has already been taken'] }, status: :unprocessable_entity
    elsif @item.save
      render json: serializer.new(@item), status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      render json: serializer.new(@item)
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:day) || ApplicationController::Parameters.new
  end

  def serializer
    ItemSerializer
  end
end
