class Api::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # corresponds to POST api/messages/
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: { "status": "success" }, status: 200
    else
      render json: {}, status: 401
    end
  end

  # corresponds to GET api/messages/:id
  def show
    render json: get_message()
  end

  # corresponds to GET api/messages
  def index
    render json: Message.all
  end

  # corresponds to GET 'api/user/:id_1/messages-from-sender/:id_2'
  def receivedMessagesFromSender
    render json: Message.where(receiver_id: params[:id_1].to_i, sender_id: params[:id_2].to_i, created_at: (Time.now - 30.day)..Time.now).limit(100)
  end

  # corresponds to GET 'api/user/:id/messages-to-user'
  def receivedMessagesToUser
    render json: Message.where(receiver_id: params[:id], created_at: (Time.now - 30.day)..Time.now).limit(100)
  end

  # corresponds to GET api/recent-messages
  def recentMessages
    render json: last_30_days_limit_100
  end

  # corresponds to DELETE api/messages/:id
  def destroy
    get_message().delete
  end

  private

  def get_message
    Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:subject, :body, :sender_id, :receiver_id)
  end

  def last_30_days_limit_100
    Message.where({ created_at: (Time.now - 30.day)..Time.now }).limit(100)
  end
end