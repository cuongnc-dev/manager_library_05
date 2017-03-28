module ApplicationHelper
  def is_active controller
    params[:controller] == controller ? "active" : nil
  end

  def title_limit_book title
    title.truncate Settings.title_limit_book
  end

  def name_limit_book name
    name.truncate Settings.name_limit_book
  end

  def name_limit_publisher name
    name.truncate Settings.name_limit_publisher
  end

  def name_limit name
    name.truncate Settings.name_limit
  end

  def home_description_limit description
    description.truncate Settings.home_description_limit
  end

  def description_limit description
    description.truncate Settings.description_limit
  end

  def info_description_limit description
    description.truncate Settings.info_description_limit
  end

  def col_serial counter
    counter + Settings.one
  end
end
