module CategoriesHelper
  def categories_output(categories)
    output = ''
    categories.each do |category|
      output += render partial: 'categories/category', locals: { category: category }
      if category.children.any?
        output += "<ol class='dd-list'>"
        output += categories_output(category.children)
        output += '</ol>'
      end
      output += '</li>'
    end
    output
  end
end