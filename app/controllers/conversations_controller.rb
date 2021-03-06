class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counts, except: :show

  def index
    @conversations = Conversation.where(recipient: current_user)
    render :list
  end

  def show
    @conversation = Conversation.friendly.find(params[:id])
  end

  def sent
    @conversations = Conversation.where(sender: current_user)
    render :list
  end

  private

  def set_counts
    @amount_sent = Conversation.where(sender: current_user).count
  end
end
