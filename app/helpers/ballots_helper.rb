module BallotsHelper
  def ballot_item_info(ballot_item)
    x = ""

    if !ballot_item.nominee.blank?
      x += "<strong>#{ballot_item.nominee} #{ballot_item.role.blank? ? "" : "(#{ballot_item.role})"}</strong><br />"
      x += "#{ballot_item.show} (#{ballot_item.theater_name})"
    else
      x += "<strong>#{ballot_item.show}</strong> (#{ballot_item.theater_name})"
    end

    return x.html_safe
  end
end
