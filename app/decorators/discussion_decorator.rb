module DiscussionDecorator
  def description
    "Auswertung der Diskussion \"#{topic}\" für #{company_name} am #{l due_date.to_date}"
  end
end