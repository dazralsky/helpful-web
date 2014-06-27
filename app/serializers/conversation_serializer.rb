class ConversationSerializer < BaseSerializer
  attributes :account_slug, :archived, :create_message_path, :last_activity_at,
    :message_count, :number, :path, :subject, :summary, :tags, :assignees_path,
    :tags_path, :canned_responses_path, :unread

  has_one :creator_person
  has_many :messages
  has_many :assignment_events
  has_many :tag_events

  def unread
    object.message_count - object.read_receipts.count > 0
  end

  def account_slug
    object.account.slug
  end

  def summary
    ConversationSummarizer.new(object).summary
  end

  def path
    "/#{account_slug}/#{number}"
  end

  def create_message_path
    url_helpers.account_messages_path(object.account)
  end

  def assignees_path
    url_helpers.account_conversation_assignees_path(object.account, object)
  end

  def tags_path
    url_helpers.account_conversation_tags_path(object.account, object)
  end

  def canned_responses_path
    url_helpers.account_canned_responses_path(object.account)
  end
end
