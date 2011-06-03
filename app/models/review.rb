class Review
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps

  embedded_in :kid

  field :held_at, :type => Date
  field :reason
  field :kind
  field :content
  field :outcome
  field :note

  def display_name
    return "Neue Gesprächsdoku" if new_record?
    "Gespräch vom #{I18n.l(held_at.to_date)}"
  end

  def human_content; content.textilize; end
  def human_reason; reason.textilize; end
  def human_outcome; outcome.textilize; end
  def human_note; note.textilize; end

end