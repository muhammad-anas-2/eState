json.success = true
json.posts @resources do |resource|
  json.partial! 'api/v1/posts/post', post: resource
end