class Registration < ApplicationRecord
  belongs_to :event
  belongs_to :user

  delegate :name, :email, to: :user

  HOW_HEARD_OPTIONS = [
    "Newsletter",
    "Blog Post",
    "Twitter",
    "Web Search",
    "Friend/Coworker",
    "Other"
  ]

  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
end
