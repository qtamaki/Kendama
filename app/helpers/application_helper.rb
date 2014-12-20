module ApplicationHelper
  def te(num, thumbnail=false)
    option = {:te => num, :size => '200x200', :onclick => "return set_card_list($(this));"}
    if thumbnail
      option[:size] = '80x80'
      option.delete(:onclick)
    end
    image = {0 => 'gu.jpg', 1 => 'choki.jpg', 2 => 'pa.jpg'}[num.to_i]
    image_tag image, option
  end
end
