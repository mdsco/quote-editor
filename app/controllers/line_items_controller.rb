# app/controllers/line_item_controller.rb

class LineItemsController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date
  before_action :set_line_item, only: [:edit, :update, :destroy]

  def new
    debugger
    @line_item = @line_item_date.line_items.build
  end

  def create
    @line_item = @line_item_date.line_items.build(line_item_params)

    if @line_item.save
      respond_to do |format|
        format.html { redirect_to quote_path(@quote), notice: "Item created successfully." }
        format.turbo_stream { flash.now[:notice] = "Item created successfully." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @line_item.update(line_item_params)
      respond_to do |format|
        format.html { redirect_to quote_path(@quote), notice: "Item updated successfully." }
        format.turbo_stream { flash.now[:notice] = "Item updated successfully." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @line_item.destroy

    redirect_to quote_path(@quote), notice: "Item destroyed successfully."
  end

  private

  def line_item_params
    params.require(:line_item).permit(:name, :quantity, :unit_price, :description)
  end

  def set_quote
    @quote = current_company.quotes.find(params[:quote_id])
  end

  def set_line_item_date
    @line_item_date = @quote.line_item_dates.find(params[:line_item_date_id])
  end

  def set_line_item
    @line_item = @line_item_date.line_items.find(params[:id])
  end
end