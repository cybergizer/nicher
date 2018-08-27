module HierarchyHelper
  def collapsed_class(object)
    object.children.any? ? 'dd-collapsed' : ''
  end

  def hierarchy_output(objects, template: 'niche')
    objects.each_with_object('') do |object, output|
      output << render(partial: "templates/#{template}", locals: { object: object })
      children_output(object.children, output, template) << '</li>'
    end
  end

  def breadcrumb_output(object)
    object.ancestors.each_with_object('') do |object, output|
      output << "<li><a href=#{object.id}>#{object.name}</a></li>"
    end
  end

  private

  def children_output(children, output, template)
    output << (children.any? ? "<ol class='dd-list'>#{hierarchy_output(children, template: template)}</ol>" : '')
  end
end
