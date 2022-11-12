module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :message_user

    def connect
      self.message_user = find_verified_user
    end

    private

    def find_verified_user
      verified_user = env['warden'].user
      verified_user || reject_unauthorized_connection
    end
  end
end
