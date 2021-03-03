class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where(user: current_user)
  end

  def new
    @message = Message.new
    @message.conversation = @conversation
    @message.recipient = params[:recipient] if params[:recipient]
  end
end
