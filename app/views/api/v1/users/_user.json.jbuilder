json.id user.id
json.email user.email
json.api_token @session.api_token if @session
json.first_name user.first_name
json.last_name user.last_name
json.phone user.phone
json.cnic_front user.image_url "cnic_front"
json.cnic_back user.image_url "cnic_back"
json.created_at user.created_at