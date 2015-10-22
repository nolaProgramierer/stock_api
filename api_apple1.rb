require 'httparty'
require 'nokogiri'

puts "Enter your stock symbol: "
stock_input = gets.chomp

response = HTTParty.get("http://finance.yahoo.com/q?s=#{stock_input}")
dom = Nokogiri::HTML(response.body)
stock_downcase = stock_input.downcase
stk_query = dom.xpath("//span[@id='yfs_l84_#{stock_downcase}']").first
  if stk_query == nil
    puts "You entered an incorrect stock symbol."
  else
    stk_low = dom.xpath("//span[@id='yfs_g53_#{stock_downcase}']").first
    stk_high = dom.xpath("//span[@id='yfs_h53_#{stock_downcase}']").first
    puts "The current price of your stock is $#{stk_query.content}."
    puts "The day's trading range was between $#{stk_low.content} and $#{stk_high.content}. "
  end
