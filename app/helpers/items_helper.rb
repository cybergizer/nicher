module ItemsHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title.to_s.html_safe, column: column, direction: direction
  end

  def search_for_first_niche(audit)
    Niche.find(audit.audited_changes['niche_id'].first)
  end

  def search_for_last_niche(audit)
    Niche.find(audit.audited_changes['niche_id'].last)
  end

  def search_for_first_category(audit)
    Category.find(audit.audited_changes['category_id'].first)
  end

  def search_for_last_category(audit)
    Category.find(audit.audited_changes['category_id'].last)
  end
end
