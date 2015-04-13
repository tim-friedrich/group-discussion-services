module ArgumentDecorator
  def votes_in_text
    res = "".html_safe
    if votes?
      res << " ("
      if likes?
        res << "#{likes_count} Like#{'s' if likes_count != 1}"
        res << ", " if dislikes?
      end
      if dislikes?
        res << "#{dislikes_count} Dislike#{'s' if dislikes_count != 1}"
      end
      res << ")"
    end
    res
  end
end