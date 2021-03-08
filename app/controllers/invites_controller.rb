class InvitesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @invites = Invite.all
  end

  def new
    Invite.create!
    redirect_to action: :index
  end
end
