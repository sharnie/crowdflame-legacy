module ApplicationHelper
  def flash_class level
    case level
      when 'notice'  then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error'   then "alert alert-danger"
      when 'alert'   then "alert alert-warning"
    end
  end

  def avatar_url user, size=40
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    current_user.profile_picture || "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}d=mm"
  end

  def list_link resource_name, resource
    class_name = "active" if current_page?(resource)
    content_tag(:li, class: class_name) do
      link_to resource_name, resource
    end
  end
end
