module SocialconnectionsHelper
  def form_collection collection_name
    case collection_name
    when :age
      ["17 and under", "18-24", "25-34", "35-44", "45-54", "55+"]
    when :language
      ["English", "Spanish", "French"]
    end
  end

  def current_category connection
    connection.category.id if connection.category
  end
end