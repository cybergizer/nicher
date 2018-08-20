module NichesHelper
  def niches_output(niches)
    output = ''
    niches.each do |niche|
      output += render partial: 'niches/niche', locals: { niche: niche }
      if niche.children.any?
        output += "<ol class='dd-list'>"
        output += niches_output(niche.children)
        output += '</ol>'
      end
      output += '</li>'
    end
    output
  end
end