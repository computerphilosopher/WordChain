#encoding: utf-8
#chcp 65001로 인코딩 할 것 

class Word
  def initialize(dic, string, killer)

    @dic = dic

    @user_word = string

    @killer_dic = killer

    @candidate = Array.new 
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

  def can_kill?
    p @killer_dic & @candidate
    
  end
end



class Dictionary

  attr_reader :word_list, :last_letter, :first_letter
  def initialize(txt)

    @word_list = txt

    @last_letter = Array.new
    @first_letter = Array.new
  end


  def reprocess
    @word_list.each do |word|
      word = word.chomp!
      word = word.force_encoding("UTF-8")
    end
  end

  def extract_letter
    @word_list.each do |word|
      word.force_encoding("UTF-8")
      @last_letter.push(word.reverse[0]) 
      @first_letter.push(word[0])
    end
  end

  def show_last
    p @last_letter
  end
end

class Killer_Dic < Dictionary  

  attr_reader :killer_list

  def show_killer
    p @killer_word
  end

  def killer_last

    @uniq_last = @last_letter

    @uniq_last.each do |letter|
      if @first_letter.include?(letter)
        @uniq_last.delete(letter)
      end
    end

    File.open("uniq.txt","w:UTF-8"){ |f|
      f.puts @uniq_last
    }

  end

  def killer_word
    @killer_list = Array.new
    @word_list.each do |word|
      if @uniq_last.include?(word.reverse[0])
        @killer_list.push(word)
      end
    end
  end
end

f = File.open('kor_dic.txt') 
txt = f.readlines

dic = Dictionary.new(txt)
dic.reprocess
dic.extract_letter

k = Killer_Dic.new(txt)
k.extract_letter
k.killer_last
k.killer_word


w = Word.new(dic.word_list, "날개", k.killer_list) 
w.make_candidate
w.can_kill?
