#!/bin/ruby

require 'net/http'
require 'nokogiri'
require 'twilio-ruby'

WAIT_TIME = 15
account_sid = 'TWILIO_ACCOUNT'
auth_token = 'TWILIO_TOKEN'

from_number = '+15555555555'
notification_number = '+15555555555'

client = Twilio::REST::Client.new(account_sid, auth_token)

last_time = 0
previous_repos = []
while true do
	# web request
	uri = URI('https://github.com/chrisvfritz')
	content = Net::HTTP.get(uri)

	# parse content
	parsed = Nokogiri::HTML(content)
	repos = parsed.css('.pinned-repo-item-content .d-block a').map do |r|
		r.text.strip
	end

  # ??? (process)
  if repos - previous_repos != []
    time = Time.now.to_i
    if time_past(time, last_time)
      # send text
      client.messages.create(
        from: from_number,
        to: notification_number,
        body: 'Repos changed'
      )
      last_time = time
    end

    previous_repos = repos
  end

	sleep(2)
end
