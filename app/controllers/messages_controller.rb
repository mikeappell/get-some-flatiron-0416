class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    # message hits here once but prints out twice. issue not here. 
    if @message.save
      ActionCable.server.broadcast 'items',
        message: @message.content,
        user: @message.user.username,
        element: '#messages',
        action: "add-message"
      head :ok
    else
      
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :order_id)
  end
end
