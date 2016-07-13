class Promotion < ActiveRecord::Base

  def safe_content
    content.html_safe if content
  end
end
