class MessagesController < ApplicationController
  before_action :require_user

  def create
    @NewMessage = Message.new(message_params)
    @NewMessage.chef = current_chef

    if @NewMessage.save
      ActionCable.server.broadcast 'chatroom_channel',message: render_message(@NewMessage),
                                   chef: @NewMessage.chef.chefname
    else
      render 'chatrooms/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    render(partial: 'message', locals: { message: message})
  end
end