require 'chrome_remote'

class CLI
  def cmd_init
    url = 'https://www.amazon.co.jp/mn/dcw/myx.html/ref=kinw_myk_redirect'
    chrome.send_cmd 'Page.navigate', url: url
    puts <<-END
Opened #{url}
 and listening at http://localhost:9222/ (headless chrome)

1. open http://localhost:9222/
2. select amazon.co.jp session and login if not yet
3. load kindle list manually
4. execute extract command
    END
  end

  def cmd_extract
    code = %Q!$('div[view="contentTab_list_desktop_tmyx"]').map((i,x) => $(x).attr('name') )!
    out = chrome.send_cmd 'Runtime.evaluate', expression: code, returnByValue: true

    result_value = out['result']['value']
    length = result_value['length'].to_i
    asins = (0...length).map do |i|
      result_value[i.to_s].sub(/^contentTabList_/, '')
    end
    p asins

    puts "extracted #{asins.length} items"
  end

  def cmd_usage
    puts "USAGE: #{$0} {init|extract}"
  end

  def chrome
    @chrome ||= init_chrome
  end

  private def init_chrome
    chrome = ChromeRemote.client
    chrome.send_cmd "Network.enable"
    chrome.send_cmd "Page.enable"
    chrome.send_cmd "Runtime.enable"
    chrome.send_cmd "Input.enable"
    chrome
  end
end

cli = CLI.new

cmd = ARGV.shift
case cmd
when 'init'
  cli.cmd_init
when 'extract'
  cli.cmd_extract
else
  cli.cmd_usage
end
