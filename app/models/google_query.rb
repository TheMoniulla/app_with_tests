class GoogleQuery < ActiveRecord::Base
  validates :value, presence: true
end
