class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.inbox(current_user)
    render :list
  end

  def show
    @conversation = Conversation.friendly.find(params[:id])
    @last_unread = @conversation.unreads_for(current_user).last
    @message = Message.new(conversation_id: @conversation.id)

    if @conversation.unreads_for?(current_user)
      @conversation.unreads_for(current_user).each do |message|
        message.update!(read: true)
      end
    end

    head :forbidden if (@conversation.sender != current_user) && (@conversation.recipient != current_user)
  end

  def sent
    @conversations = Conversation.where(sender: current_user)
    render :list
  end
end
