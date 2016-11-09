# Ruby User Group, 08 Nov 2016

Text alerting on a website content change

* web request

```
require 'net/http'
uri = URI('https://github.com/chrisvfritz')
content = Net::HTTP.get(uri)
```

* parse content

```
require 'nokogiri'
parsed = Nokogiri::HTML(content)
chris_face = parse.css('.avatar').attr('src').value
```

* ??? (process)

* send text

```
require 'twilio-ruby'
client = Twilio::REST::Client.new(account_sid, auth_token)
client.messages.create(
  from: from_number,
  to: notification_number,
  body: 'Repos changed'
)
```
