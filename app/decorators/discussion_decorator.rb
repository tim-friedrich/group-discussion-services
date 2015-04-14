module DiscussionDecorator
  def description
  	if company_name
    	"Auswertung der Diskussion \"#{topic}\" für #{company_name} am #{l due_date.to_date}"
    else
      "Auswertung der Diskussion \"#{topic}\" vom #{l due_date.to_date}"
    end
  end
end