require 'survey_analyzer'

prawn_document do |pdf|
  h1 = 25
  h2 = 20
  h3 = 15

  pdf.bounding_box([pdf.bounds.left, pdf.bounds.top - 45], :width  => pdf.bounds.width, :height => pdf.bounds.height - 50) do
    pdf.font_size(h1){ pdf.text @discussion.description }
    pdf.move_down(h2)
    if @discussion.summary.present?
      pdf.font_size(h2){ pdf.text "Zusammenfassung" }
      pdf.move_down 30
      pdf.text @discussion.summary
    end
    pdf.start_new_page

    unless @discussion.confirmed_probands.empty?
      pdf.font_size(h2){ pdf.text "Probanden" }
      pdf.move_down 10

      @discussion.confirmed_probands.each{ |discussion_user|
        pdf.stroke_horizontal_rule
        pdf.move_down 10

        pdf.font_size(h3){ pdf.text "#{discussion_user.name}: #{discussion_user.user.age} / #{I18n.t(discussion_user.user.gender || 'other')}" }
        pdf.text "Postleitzahl: #{discussion_user.user.zipcode}" if discussion_user.user.zipcode

        if discussion_user.user.has_survey?
          pdf.text "Persönlichkeit:"
          pdf.image "data/charts/user/#{discussion_user.user.id}.png", :scale => 0.4

          pdf.bounding_box([0, pdf.cursor + 4], :width => pdf.bounds.right, height: 140) do
            SurveyAnalyzer::SCALE_NAMES.each.with_index{ |scale_name, index|
              short_scale_name = scale_name
                .gsub("Bedürfnis nach", "")
                .gsub(" und ", " / ")
              pdf.draw_text short_scale_name, at: [pdf.bounds.left + 50*(index+1), pdf.bounds.top], rotate: 270
            }
          end
        end
      }
    end

    pdf.start_new_page

    unless @discussion.arguments.empty?
      pdf.font_size(h2){ pdf.text "Transkript" }
      pdf.move_down 10

      @discussion.questions.each do |question|
        pdf.move_down 10
        pdf.font_size(h3){ pdf.text question.topic.to_s }
        pdf.move_down 10
        pdf.stroke_horizontal_rule
        question.arguments.includes(:user, :votes).each do |argument|
          argument = decorate(argument)
          pdf.pad(5){ pdf.text argument.user.username_in(@discussion) + ": " + argument.content + argument.votes_in_text }
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



