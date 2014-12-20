# -*- encoding: utf-8 -*-
class Scoreline < ActiveRecord::Base
  def Scoreline.match(src_user, dst_user)
    src_cards = src_user.card_list.split(",").map{|x| [x,0]}
    dst_cards = dst_user.card_list.split(",").map{|x| [x,0]}
    matches(src_cards, dst_cards).reverse
  end

  def Scoreline.matches(src, dst)
    if src.empty?
      #dst.select{|x| x[1] == 0 }.map{|x| [[], x, nil, nil]}.reverse
      dst.map{|x| [[], x, nil, nil]}.reverse
    elsif dst.empty?
      #src.select{|x| x[1] == 0 }.map{|x| [x, [], nil, nil]}.reverse
      src.map{|x| [x, [], nil, nil]}.reverse
    else
      s = src.shift
      d = dst.shift
      case match_check(s[0], d[0])
      when :win
        src.unshift([s[0],s[1]+1])
        matches(src, dst) << [s, d, :win, :lose]
      when :lose
        dst.unshift([d[0],d[1]+1])
        matches(src, dst) << [s, d, :lose, :win]
      when :draw
        matches(src, dst) << [s, d, :draw, :draw]
      end
    end
  end

  def Scoreline.match_check(src, dst)
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

  def Scoreline.judge(res)
    res.each do |x|
      return :lose if x[0].empty?
      return :win if x[1].empty?
    end
    return :draw
  end
end

