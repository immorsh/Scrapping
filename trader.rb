require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_crypto_values(crypto_url)
  crypto = {}
  page = Nokogiri::HTML(open(crypto_url))
  crypto[:name] = page.xpath("/html/body/div[2]/div/div[1]/div[3]/div[1]/h1/text()").text.strip
  crypto[:value] = page.xpath("//*[@id='quote_price']/span[1]").text
  crypto
end

def get_all_the_urls_of_cryptos(website_url, page)
  urls = []
  page = Nokogiri::HTML(open(website_url + page))
  page.xpath("//a[@class = 'link-secondary']/@href").each do |crypto|
    urls << website_url + crypto.text[1..-1]
  end
  urls
end

def get_all_the_cryptos_values(website_url, page)
  cryptos = []
  urls = get_all_the_urls_of_cryptos(website_url, page)
  urls.each do |url|
    p crypto = get_crypto_values(url)
    cryptos << crypto
  end
  cryptos
end

url = "https://coinmarketcap.com/"
page = "all/views/all/"

puts get_all_the_cryptos_values(url, page)
