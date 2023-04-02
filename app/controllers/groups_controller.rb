class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all

    # @notifier = {
    #   title: 'Notification from the Group controller',
    #   body: 'This is a random notification just shown up here for testing purposes'
    # }
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(sanitize.merge(author: current_user))

    # authorize! :create, @group

    icon = params[:group][:icon]
    @group.icon.attach(icon) if icon

    if @group.valid? && @group.save
      redirect_to groups_path, notice: 'Group was created'
    else
      render :new
    end
  end

  private

  def sanitize
    params.require(:group).permit(:name, :icon)
  end
end
