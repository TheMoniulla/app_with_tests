class Currency < ActiveRecord::Base
  has_many :expenses

  validates :name, presence: true

  def to_s
    name
  end
end