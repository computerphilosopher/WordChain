#encoding: utf-8

class Word
  def initialize(dic, string)
    
    @dic = dic
    
    @user_word = string
   
    @candidate = []
  end

  def last_letter
    return @user_word[-1,1]
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


    
f = File.open('kor_dic.txt')
dic = f.readlines


w = Word.new(dic, "김선달")
w.make_candidate
w.show_candidate


