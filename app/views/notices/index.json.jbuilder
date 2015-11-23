json.array!(@notices) do |notice|
  json.extract! notice, :id
  json.url notice_url(notice, format: :json)
end
