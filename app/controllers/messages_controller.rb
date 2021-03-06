class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @message = Message.new
    @message.recipient = params[:recipient] if params[:recipient]
  end

  def create
    @message = Message.new(message_params.merge(user: current_user))
    @message.conversation = Conversation.new(
      subject: @message.subject,
      sender: current_user,
      recipient: User.find_by_username(@message.recipient)
    )

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message.conversation, notice: 'Message sent!' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body, :recipient)
  end
end
