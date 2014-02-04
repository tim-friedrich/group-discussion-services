json.array!(@research_institutes) do |research_institute|
  json.extract! research_institute, :name, :kontakt_id
  json.url research_institute_url(research_institute, format: :json)
end
