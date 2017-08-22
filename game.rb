#encoding: utf-8
#chcp 65001로 인코딩 할 것 

class Word
  def initialize(dic, string)
    
    @dic = dic
    
    @user_word = string
 
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
    @first_letter = Array.new
    @killer_word = Array.new
    
    @dic.each do |word|
      word.force_encoding("UTF-8")
      @last_letter.push(word.reverse[0]) 
      @first_letter.push(word[0])
    end

    #중복제거
    @last_letter = @last_letter.uniq
    @first_letter = @first_letter.uniq
  end

def show_last
    p @last_letter
  end

def show_killer
  puts @killer_word
  end

def uniq_arr
  @uniq_letter = @last_letter.uniq
  
  @uniq_first = @first_letter.uniq
  end


def killer_last

  @last_letter.each do |letter|
    if @first_letter.include?(letter)
      @last_letter.delete(letter)
    end
  end

  File.open("uniq.txt","w:UTF-8"){ |f|
    f.puts @last_letter
  }

end

def killer_word
  @dic.each do |word|
    if @last_letter.include?(word.reverse[0])
        @killer_word.push(word)
    end
  end
  
end
end


def remove_newline(dic)
  dic.each do |word|
    word = word.chomp!
    word = word.force_encoding("UTF-8")
  end

  return dic
end

      
f = File.open('kor_dic.txt')
dic = f.readlines
dic= remove_newline(dic)


p dic

w = Word.new(dic, "날개")

k = Killer.new(dic)

k.killer_last


k.killer_word

k.show_last
