#encoding: utf-8

#chcp 65001로 인코딩 할 것 

class Word
  def initialize(dic, string)
    
    @dic = dic
    
    @user_word = string
    puts @user_word
 
    @candidate = []
  end

  def in_dic?
    return @dic.include?(user_word)
  end

  def make_candidate
    @dic.each do |word|
      if word[0] == @user_word[-1]
        @candidate.push(word)
    end
  end
end

  def show_candidate
    if @candidate == nil 
      puts "사전에 없습니다."
    else
      puts @candidate
    end
  end
end


class Killer
  def initialize(dic)
    @dic = dic
    @last_letter = Array.new
    
    @dic.each do |word|
      word.force_encoding("UTF-8")
      @last_letter.push(word.reverse[2]) #word 뒤의 두 글자가 공백임
    end
  end

def show_last
    puts @uniq_letter
  end

def uniq_last
  @uniq_arr = @last_letter.uniq
  File.open("uniq.txt","w:UTF-8"){ |f|
    f.puts @last_letter
  }
  
  end
end

    
f = File.open('kor_dic.txt')
dic = f.readlines

w = Word.new(dic, "날개")

k = Killer.new(dic)

k.uniq_last
k.show_last
