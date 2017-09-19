require 'chrome_remote'

chrome = ChromeRemote.client

chrome.send_cmd "Network.enable"
chrome.send_cmd "Page.enable"
chrome.send_cmd "Runtime.enable"
chrome.send_cmd "Input.enable"

chrome.on "Network.requestWillBeSent" do |params|
  #p params["request"]["url"]
end
#=begin
chrome.send_cmd 'Page.navigate', url: 'https://www.amazon.co.jp/mn/dcw/myx.html/ref=kinw_myk_redirect'
chrome.wait_for 'Page.loadEventFired'

sleep 10

puts 'scroll!'
require 'pry'; binding.pry
chrome.send_cmd 'Input.synthesizeScrollGesture', x: 0, y: 0, yDistance: -1000, speed: 10_000

sleep 3

code = %Q!$('div[view="contentTab_list_desktop_tmyx"]').map((i,x) => $(x).attr('name') )!
#out = chrome.send_cmd 'Runtime.evaluate', expression: %Q!["hello","world"]!, returnByValue: true
out = chrome.send_cmd 'Runtime.evaluate', expression: code, returnByValue: true

result_value = out['result']['value']
# p out
length = result_value['length'].to_i
(0...length).each do |i|
  p result_value[i.to_s]
end

puts "extracted #{length} items"
#=end

#out = chrome.send_cmd 'Runtime.evaluate', expression: %Q!["hello","world"]!, returnByValue: true
#p out

#chrome.listen
