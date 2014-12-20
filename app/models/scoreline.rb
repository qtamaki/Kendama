# -*- encoding: utf-8 -*-
class Scoreline < ActiveRecord::Base
  def match(src_user, dst_user)
    src_cards = src_user.card_list.split(",")
    dst_cards = dst_user.card_list.split(",")
    matches(src_cards, dst_cards).reverse
  end

  def matches(src, dst)
    if src.empty?
      dst.map{|x| [nil, x, nil, nil]}.reverse
    elsif dst.empty?
      src.map{|x| [x, nil, nil, nil]}.reverse
    else
      s = src.shift
      d = dst.shift
      case match_check(s, d)
      when :win
        src.unshift(s)
        matches(src, dst) << [s, d, :win, :lose]
      when :lose
        dst.unshift(d)
        matches(src, dst) << [s, d, :lose, :win]
      when :draw
        matches(src, dst) << [s, d, :draw, :draw]
      end
    end
  end

  def match_check(src, dst)
    # 0:gu, 1:choki, 2:pa
    {"00" => :draw,
     "01" => :win,
     "02" => :lose,
     "10" => :lose,
     "11" => :draw,
     "12" => :win,
     "20" => :win,
     "21" => :lose,
     "22" => :draw}[src.to_s + dst.to_s]
  end
end

