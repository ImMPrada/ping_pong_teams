class InvitationSender
  attr_reader :error_messages, :invitation

  def initialize(sender, recipient, team)
    @sender = sender
    @recipient = recipient
    @team = team
    @error_messages = []
  end

  def valid?
    validate

    @error_messages.empty?
  end

  def create
    return false unless valid?

    @invitation = Invitation.create(
      team: @team,
      recipient: @recipient,
      sender: @sender,
      active: true
    )
  end

  private

  def validate
    @error_messages << 'Recipient is already a team member' if recipient_already_member?
    @error_messages << 'Recipient has already an active invitation' if recipient_already_invited?
    @error_messages << "Sender can't send an invitation to itself" if recipient_self_invited?
  end

  def recipient_already_member?
    @recipient.member_of?(@team)
  end

  def recipient_already_invited?
    @recipient.received_invitations.where(
      team: @team,
      active: true
    ).present?
  end

  def recipient_self_invited?
    @recipient == @sender
  end
end
