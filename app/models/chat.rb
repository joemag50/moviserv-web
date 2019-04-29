class Chat < ApplicationRecord

  def self.find_chat(params = {})
    result = Chat.find_by(from_user: params[:user_id],
                          to_user: params[:receiver_id])
    return result if result
    Chat.find_by(to_user: params[:user_id], from_user: params[:receiver_id])
  end

  def self.find_my_chats(params = {})
    result = []

    Chat.where(from_user: params[:user_id]).map { |chat|
      x = {
        chat_id: chat.id,
        partner_email: User.find(chat.to_user).email
      }
      result << x
    }

    Chat.where(to_user: params[:user_id]).map { |chat|
      x = {
        chat_id: chat.id,
        partner_email: User.find(chat.from_user).email
      }
      result << x
    }

    result
  end
end
