class Tagging < ApplicationRecord
  belongs_to :question
  belongs_to :tag

  validates :tag, uniqueness: {scope: :question_id}
end
