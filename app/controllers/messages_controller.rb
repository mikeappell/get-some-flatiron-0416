class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save
      ActionCable.server.broadcast 'messages',
        message: @message.content,
        user: @message.user.username
      head :ok
    else
      
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :order_id)
  end
end
