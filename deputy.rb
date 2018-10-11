require 'rubygems'
require  'nokogiri'
require 'open-uri'

def  get_contact(url)
    contact = {}
    page = Nokogiri::HTML(open(url)) 
    nom_prenom = page.xpath('//*[@id="haut-contenu-page"]/article/div[2]/h1').text.split(" ") #.text c'est pour récuperer juste la partie  texte qui m'interesse et la methode split c'est enlever les spaces 
    contact[:lastname] = nom_prenom[2]# pour prendre la case qui m'interesse
    contact[:firstname] = nom_prenom[1] 
    contact[:email] = page.xpath('//*[@id="deputes-contact"]/section/dl/dd[1]/a/@href').text.split(':')[1]
    return contact
end

def get_all_urls(website, url_list)
    page = Nokogiri::HTML(open(website+url_list))
    urls =[]
    page.xpath('//*[@id="deputes-list"]/div/ul/li/a/@href').each do |contact|
        urls << website + contact.text
    end
    urls
end

def get_all_contacts(website, url_list)
    contacts = []
    urls = get_all_urls(website, url_list)
    urls.each do |url|
        p contact = get_contact(url)
        contacts << contact
    end
    contacts
end

p get_all_contacts('http://www2.assemblee-nationale.fr' , '/deputes/liste/alphabetique')
