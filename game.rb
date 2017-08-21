#encoding: utf-8

class Word
  def initialize(dic, string)
    
    @dic = dic
    @user_word = string
    @candidate = Array.new
  end

  def last_letter
    return @user_word[-1,1]
  end

  def in_dic?
    return @dic.include?(user_word)
  end

  def make_candidate
    @dic.each do |word|
      if word[0] == @user_word[-1,1]
        @candidate.push(word)
      end
    end
  end

  def show_candidate
    if @candidate == nil 
      puts "사전에 없습니다."
    else
      @candidate.each do |word|
      p word
      end
    end
  end
end


test = Array.new
    
f = File.open('kor_dic.txt')
a = f.readlines
puts a[2]





