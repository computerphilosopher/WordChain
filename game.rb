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
			if word[0] == @user_word.reverse[0]
				@candidate.push(word)
			end
		end
	end

	def show_candidate
		if @candidate == nil 
			puts "not in dictionary"
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
			word = word.encode("UTF-8")

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

	attr_reader :killer_list, :uniq_last

	def show_killer
		p @killer_word
	end

	#첫 글자에 등장하지 않는 글자 추출
	
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

	#killer_last를 끝 글자로 하는 단어 추출

	def killer_word
		@killer_list = Array.new
		@word_list.each do |word|
			if @uniq_last.include?(word.reverse[0])
				@killer_list.push(word)
			end
		end
	end
end

class Jamo_handler 
	attr_reader :chosung, :jungsung, :jongsung, :chosung_code

	def initialize(input)
		@letter = input
		@unpacked = input.unpack("U*")

		@syllable_start = 0xAC00
		@hangul_index = @unpacked[0]-@syllable_start 

	end

	def get_chosung

		chosung_start = 0x1100 
		@chosung_code = (@hangul_index/28/21)+chosung_start

		@chosung = [@chosung_code]

	end

	def get_jungsung

		jungsung_start = 0x1161 
		@jungsung_code = ((@hangul_index/28)%21)+jungsung_start

		@jungsung = [@jungsung_code]

	end

	def get_jongsung

		jongsung_start = 0x11A8 
		@jongsung_code = (@hangul_index%28)+jongsung_start-1
		@jongsung = [@jongsung_code]
	end

	def repack_seperated
		@chosung = @chosung.pack("U*") 
		@jungsung = @jungsung.pack("U*")
		@jongsung = @jongsung.pack("U*")
	end

	def detach_jongsung 
		p @unpacked[0] 
		detached= @unpacked[0]-(@jongsung_code-4519)
		p [detached].pack("U*")
	end
		

	def show_index
		puts @chosung_code
		puts @jungsung_code
		puts @jongsung_code
	end

	def show_split
		puts [@chosung, @jungsung, @jongsung]
	end
end


#두음 법칙
class Head_sound_converter < Jamo_handler
	
	def test
		p @chosung
	end

end

#f = File.open("kor_dic.txt") 
#txt = f.readlines

#dic = Dictionary.new(txt)
#dic.reprocess
#dic.extract_letter


#k = Killer_Dic.new(txt)
#k.extract_letter
#k.killer_last
#k.killer_word



b= Jamo_handler.new('람')
b.get_chosung
b.get_jungsung
b.get_jongsung
b.detach_jongsung
