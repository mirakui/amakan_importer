require 'chrome_remote'

chrome = ChromeRemote.client

chrome.send_cmd "Network.enable"
chrome.send_cmd "Page.enable"

chrome.on "Network.requestWillBeSent" do |params|
  p params["request"]["url"]
end

chrome.send_cmd 'Page.navigate', url: 'https://www.amazon.co.jp/mn/dcw/myx.html/ref=kinw_myk_redirect'
chrome.wait_for 'Page.loadEventFired'

puts 'onload!'
