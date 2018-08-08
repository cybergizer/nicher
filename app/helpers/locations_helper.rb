module LocationsHelper
  def find_location(location, id)
    child = nil
    location.cheldren.each do children
      child = find_location(children, id)
      if children.id == id
        child = children
      end
    end
    child
  end
end