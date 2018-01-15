# encoding: utf-8

require_relative './access_key'

require './game'

require 'twitter'


class Account
	include Twitter_access

	attr_reader :timeline_text, :mention_text

	def initialize
		@client =get_client()
		@timeline = @client.user_timeline("oneturnbot")
		@timeline_text = Array.new
		@mention = @client.mentions_timeline
		@mention_text = Array.new 
	end

	def post(text)
		client.update(text)
	end

	def fetch_timeline

		@timeline.each do |tweet|

			@timeline_text.push (@client.status(tweet).text)

		end
	end

	def fetch_mention

		@mention.each do |mention|

			@mention_text.push (@client.status(mention).text)

		end

	end

end

acc = Account.new

acc.fetch_mention()
acc.fetch_timeline()

p acc.mention_text
p acc.timeline_text





