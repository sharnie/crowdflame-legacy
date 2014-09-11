module ApplicationHelper
  def flash_class level
    case level
      when 'notice'  then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error'   then "alert alert-danger"
      when 'alert'   then "alert alert-warning"
      else 'alert alert-info'
    end
  end

  def avatar_url user, size=40
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)

    if current_user.have_connections?
      current_user.socialconnections.last.profile_picture
    else
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}d=mm"
    end
  end

  def list_link resource_name, resource
    class_name = "active" if current_page?(resource)
    content_tag(:li, class: class_name) do
      link_to resource_name, resource
    end
  end
end
