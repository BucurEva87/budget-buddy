class EntriesController < ApplicationController
  before_action :authenticate_user!, :set_group

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.create(sanitize.merge(author: current_user))
  end
  
  def index
    @entries = @group.entries
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def sanitize
    params.require(:entry).permit(:name, :amount, :groups_ids)
  end
end
