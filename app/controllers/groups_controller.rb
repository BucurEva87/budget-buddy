class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(sanitize)
    @group.icon.attach(params[:group][:icon]) if @group.icon.present?

    if @group.valid? && @group.save
      redirect_to @group, notice: 'Group was created'
    else
      render :new, alert: 'Group was not created at all'
    end
  end

  private

  def sanitize
    params.require(:group).permit(:name, :icon)
  end
end
