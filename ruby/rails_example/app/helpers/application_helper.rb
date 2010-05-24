# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def path_to_url(path)
    request.protocol + request.host_with_port + path
  end
end
