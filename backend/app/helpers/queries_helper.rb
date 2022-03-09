module QueriesHelper
  def display(query)
    query.each do |field|
      tag.ul do
        tag.li field
      end
    end
  end
end
