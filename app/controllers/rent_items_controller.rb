class RentItemsController < ApplicationController
  before_action :set_rent_item, only: %i[repay]

  def rent_form
    @rent_item = RentItem.new(item: item)
    @rent_item.tenant = Contact.new
    render partial: 'items/popups/rent_form'
  end

  def rent
    @rent_item = RentItem.new(rent_item_params.merge(item: item, owner: current_user))
    if @rent_item.save
      render json: { status: 'ok' }
    else
      render json: { status: 'error' }
    end
  end

  def repay
    @rent_item.destroy
    redirect_to items_url
  end

  private

  def set_rent_item
    @rent_item = RentItem.find(params[:id])
  end

  def rent_item_params
    params.require(:rent_item).permit(tenant_attributes: %i[name email phone_number])
  end

  def item
    current_user.items.find(params[:id])
  end
end
