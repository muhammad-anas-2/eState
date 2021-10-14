class Bank < ApplicationRecord
  has_many :accounts, foreign_key: "bank_id", class_name: 'UserBankAccount'
end
