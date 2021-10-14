json.success true
json.message "User updated Successfully"
json.user do
  json.partial! 'api/v1/users/user', user: @user
  json.address @user.address
  json.account_details @user.bank_account
end