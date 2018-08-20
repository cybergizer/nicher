module HierarchyHelper
  def hierarchy_output(objects, template: 'niche')
    objects.each_with_object('') do |object, output|
      output << render(partial: "templates/#{template}", locals: { object: object })
      children_output(object.children, output) << '</li>'
    end
  end

  private

  def children_output(children, output)
    output << (children.any? ? "<ol class='dd-list'>#{hierarchy_output(children)}</ol>" : '')
  end
end
