class Message < ApplicationRecord
  validates_presence_of :subject,
                        :body,
                        :sender_id,
                        :receiver_id
end