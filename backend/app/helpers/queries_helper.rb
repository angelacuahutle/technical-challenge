module QueriesHelper
  def display(repo)
    tag.p repo['name']
    tag.p repo['html_url']
    tag.p repo['description']
    tag.br
  end
end
