#encoding: utf-8
require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'TlhayK1pK3K9fxumidWxeoDYh'
	config.consumer_secret = 'k60hh0QsSrVu190XXPQk1eUP4B7cNGcYHNPVr93kdfj7vCPRSU'

  config.access_token = '900649195970863104-Ot37zy8Pp3sVbCKpP2oFBpmOF7WyI56'

  config.access_token_secret = 'DnA11OllbuOuMGXuSy6Ee92xZFo0aZp9Elng0IOfM5K8y'
end

test = "한글 테스트"
test = test.encode("utf-8")

client.update(test)
