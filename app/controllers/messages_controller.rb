class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = current_user.messages.build(message_params)

    if message.save
      ActionCable.server.broadcast "chatroom_channel", data: message.body, template: message_template(message)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_template(message)
    render partial: 'messages/message', locals: {message: message}
  end

end
