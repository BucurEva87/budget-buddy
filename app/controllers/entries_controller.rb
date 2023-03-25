class EntriesController < ApplicationController
  before_action :authenticate_user!, :set_group

  def new
    @entry = Entry.new
  end

  def create
    group_names = JSON.parse(params[:groups_ids]).map { |o| o['value'] }
    groups = Group.where(name: group_names)

    @entry = Entry.new(sanitize.merge(author: current_user, groups: groups))

    if @entry.valid? && @entry.save
      redirect_to group_entries_path(@group), notice: 'Transaction was made'
    else
      render :new
    end
  end
  
  def index
    @entries = @group.entries.order(created_at: :desc)
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def sanitize
    params.require(:entry).permit(:name, :amount, :groups_ids)
  end
end
