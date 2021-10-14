json.success true
json.message "OTP confirmed Successfully"
json.user do
  json.partial! 'api/v1/users/user', user: @resource
  json.address @resource.address
  json.account_details @resource.bank_account
end