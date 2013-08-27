module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def humanize_sort_direction(direction)
    direction == 'desc' ? 'descending' : 'ascending'
  end

  def humanize_sort_type(sort)
    if sort == 'birthdate'
      'Age'
    elsif sort == 'created_at'
      'Recent'
    else
      sort.humanize
    end
  end

  def flip_direction(direction)
    if direction.nil? || direction == 'asc'
      'desc'
    else
      'asc'
    end
  end

  def direction_icon(text, sort, direction)
    if text == 'Recent'
        nav = 'created_at'
    elsif  text == 'Age'
      nav = 'birthdate'
    else
      nav = text
    end

    if nav.downcase == sort
      if direction == 'asc'
        text + " <i class='icon-arrow-up'></i>"
      else
        text + " <i class='icon-arrow-down'></i>"
      end
    elsif nav == 'created_at' && !sort
      "Recent <i class='icon-arrow-up'></i>"
    else
      text + ' '
    end
  end

  def status_label(status)
    if status == "Looking For Care" || status == "Looking To Care" || status == "Visible"
      "success"
    else
      "inverse"
    end
  end

  def sidebar_welcome
    if user_signed_in?
      "Welcome, " + current_user.name.split(" ")[0]
    else
      "Your Account"
    end
  end

  def humanize_profile_class_name(class_name)
    if class_name == "CareReceiverProfile"
      "Family / Individiual Ad"
    else
      "Student Caregiver"
    end
  end
=begin

http://railscasts.com/episodes/228-sortable-table-columns

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
=end
end
