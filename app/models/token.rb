class Token < ApplicationRecord
  default_scope { where(active: true) }
  belongs_to :user
end
