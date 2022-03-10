module QueriesHelper
  def display(repo)
    tag.h2 repo['name']
    tag.p repo['html_url']
    tag.p repo['description']
  end
end
