json.array!(@group_events) do |group_event|
  json.extract! group_event, :id, :event_start, :event_end, :event_duration, :name, :description, :location, :published, :deleted
  json.url group_event_url(group_event, format: :json)
end
