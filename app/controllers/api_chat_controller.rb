class ApiChatController < ApplicationController
  def new_chat
    return unless auth_user!
    unless User.find_by(email: new_chat_params[:email])
      render json: { result: false, object: "No existe el correo" }
      return
    end

    attrs = {
      to_user: User.find_by(email: new_chat_params[:email]).id,
      from_user: @user.id
    }
    @chat = Chat.new attrs
    if @chat.save
      render json: { result: true, object: @chat }
    else
      render json: { result: false, object: @chat.errors }
    end
  end

  def chats
    return unless auth_user!

    render json: { result: true, object: Chat.find_my_chats(user_id: @user.id) }
  end

  def messages
    return unless auth_user!

    @object = Message.where(chat_id: params[:chat_id])
    render json: { result: true, object: @object }
  end

  def send_message
    return unless auth_user!

    @receiver = User.find_by(email: params[:to_user])
    @chat = Chat.find_chat(user_id: @user.id, receiver_id: @receiver.id)
    attrs = {
      message: params[:message],
      chat_id: @chat.id,
      user_id: @user.id
    }
    @message = Message.new attrs
    @message.save
    attrs = {
      message: @message.message,
      chat_id: @message.chat_id,
      user: @message.user.email
    }
    render json: { result: true, object: attrs }
  end

  private

  def auth_user!
    @user = User.find_by( email: user_params[:email] )
    unless @user
      render json: { result: false, error: "Email or Password are incorrect", error_es: 'El usuario o la contraseña son incorrectos' }
      return nil
    end
    unless @user.valid_password?(user_params[:password])
      render json: { result: false, error: "Email or Password are incorrect", error_es: 'El usuario o la contraseña son incorrectos' }
      return nil
    end
    true
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def new_chat_params
    params.require(:chat).permit(:email)
  end

  def message_params
    params.require(:message).permit(:to_user, :message)
  end
end
