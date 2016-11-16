class MessagesController < ApplicationController

  def create
    message = Message.create(message_params)
  end

  private 

  def message_params
    params.require(:body, :phone)
  end

end
