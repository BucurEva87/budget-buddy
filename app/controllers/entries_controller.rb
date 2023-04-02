class EntriesController < ApplicationController
  before_action :authenticate_user!, :set_group
  # load_and_authorize_resource

  def new
    @entry = Entry.new
  end

  def create
    groups = Group.where(name: JSON.parse(params[:entry][:groups_ids]).map { |o| o['value'] })

    @entry = Entry.new(sanitize.merge(author: current_user, groups:))

    if @entry.valid? && @entry.save
      redirect_to group_entries_path(@group), notice: 'Transaction was made'
    else
      render :new
    end
  end

  def index
    @entries = @group.entries.where(author: current_user).order(created_at: :desc)
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def sanitize
    params.require(:entry).permit(:name, :amount)
  end
end
