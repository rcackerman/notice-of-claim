json.array!(@screeners) do |screener|
  json.extract! screener, :id
  json.url screener_url(screener, format: :json)
end
