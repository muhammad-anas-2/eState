class CreateUserBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_bank_accounts do |t|
      t.string :branch_code
      t.string :account_number
      t.references :user, foreign_key: true
      t.references :bank, foreign_key: true

      t.timestamps
    end
  end
end
