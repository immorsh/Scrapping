require 'rubygems'
require 'nokogiri'     
require 'open-uri'
require 'CSV'

def get_the_email_of_a_townhal_from_its_webpage(mairie)
    page = Nokogiri::HTML(open(mairie)) 
    page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text #p pour return 
end


def get_all_the_urls_of_val_doise_townhalls(url, p)
    urls = []
    page = Nokogiri::HTML(open(url + p))
    page.xpath('//a[@class = "lientxt"]/@href').each do |town|
        urls << url + town.text[2..-1]
    end
    return urls
end 

puts get_the_email_of_a_townhal_from_its_webpage('http://annuaire-des-mairies.com/95/vaureal.html')
puts get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/", "val-d-oise.html")

