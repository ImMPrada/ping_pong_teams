class InvitationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "invitation_channel_user_#{message_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
