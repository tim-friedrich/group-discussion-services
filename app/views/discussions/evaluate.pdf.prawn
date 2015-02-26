
prawn_document() do |pdf|
  h1 = 25
  h2 = 20
  h3 = 15

  pdf.bounding_box([pdf.bounds.left, pdf.bounds.top - 45], :width  => pdf.bounds.width, :height => pdf.bounds.height - 50) do
    pdf.font_size(h1){ pdf.text "Auswertung der Diskussion: "+@discussion.topic }
    pdf.font_size(h1){ pdf.text "Vom "+(l @discussion.due_date)  }
    pdf.move_down(h2)
    pdf.font_size(h2){ pdf.text "Zusammenfassung" }
    pdf.move_down 30
    pdf.text @discussion.summary
    pdf.start_new_page

    if !@discussion.users.empty?
      pdf.font_size(h2){ pdf.text "Probanden" }
      pdf.move_down 30
      probands = [ ["Benutzername", "Geschlecht", "Alter", "Postleitzahl"] ]
      probands += @discussion.discussions_users.collect{ | user | [user.name , user.user.gender, user.user.age.to_s, user.user.zipcode]}
      pdf.table(probands, :header => true)
    end

    pdf.start_new_page

    if !@discussion.arguments.empty?

      pdf.font_size(h2){ pdf.text "Transkript" }
      pdf.move_down 10

      @discussion.questions.each do | question |
        pdf.move_down 10
        pdf.font_size(h3){ pdf.text "Frage: "+question.topic }
        pdf.move_down 10
        pdf.stroke_horizontal_rule
        question.arguments.each do | argument |
          pdf.pad(5){ pdf.text argument.user.username(@discussion)+": "+argument.content }
          pdf.stroke_horizontal_rule
        end
      end
    end
  end

  #page numbering and header
  string = "Seite <page> von <total>"
  options = { :at => [pdf.bounds.right - 150, 0],
   :width => 150,
   :align => :right,
   :start_count_at => 1}
  pdf.number_pages string, options

  pdf.repeat :all do
      # header

      pdf.canvas do

            pdf.bounding_box([pdf.bounds.left+35, pdf.bounds.top-5], :width => pdf.bounds.width) do
              pdf.image "#{Rails.root}/app/assets/images/logo.png", height: 60
            end

          end
  end

end



