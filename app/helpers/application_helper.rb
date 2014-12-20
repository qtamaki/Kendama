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

  def icon(num, size = '80x80')
    image_tag "icon#{num}.jpg", :size => size
  end

  def te2str(te)
    case te[0]
    when nil
      '-'
    when "0"
      if te[1] > 0
        '↓'
      else
        image_tag 'gu.jpg', :size => "80x80"
      end
    when "1"
      if te[1] > 0
        '↓'
      else
        image_tag 'choki.jpg', :size => "80x80"
      end
    when "2"
      if te[1] > 0
        '↓'
      else
        image_tag 'pa.jpg', :size => "80x80"
      end
    end
  end

  def res2str(re)
    case re
    when nil
      '-'
    when :win
      '勝'
    when :lose
      '負'
    when :draw
      '分'
    end
  end

  def judge2str(ju)
    image_tag "#{ju}.jpg", :size => "200x200"
  end
end
