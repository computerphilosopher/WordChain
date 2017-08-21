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
      puts word[0] == @user_word[-1]
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


    
f = File.open('test.txt')
dic = f.readlines


w = Word.new(dic, "맥주")
w.make_candidate
w.show_candidate


