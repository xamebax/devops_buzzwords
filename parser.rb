require 'nokogiri'
require 'mechanize'
require 'open-uri'

class Parser
  include Nokogiri

  # list heavily influenced by
  # http://www.stackdriver.com/top-devops-influencers-blogs-follow/
  BLOG_LIST = { 'Andrew Hay' => 'http://www.andrewhay.ca/',
                'Goat Can' => 'http://goatcan.wordpress.com/',
                'Gene Kim' => 'http://itrevolution.com/devops-blog/',
                'ScriptRock' => 'http://scriptrock.com/blog/',
                'DevOpsGuys' => 'http://blog.devopsguys.com/',
                'Kitchen Soap' => 'http://www.kitchensoap.com/',
                'Scalable Startups' => 'http://www.iheavy.com/blog/',
                'Socialized Software' => 'http://socializedsoftware.com/',
                'Marten Mickos' => 'https://www.eucalyptus.com/blog/11',
                'Agile Sysadmin' => 'http://www.agilesysadmin.net/',
                'Kevin Behr' => 'http://www.kevinbehr.com/',
                'Build Doctor' => 'http://build-doctor.com/',
                'TechnoCalifornia' => 'http://technocalifornia.blogspot.com/',
                'Adrian Cockcroft' => 'http://perfcap.blogspot.com/',
                'Test Obsessed' => 'http://testobsessed.com/',
                'Dominica DeGrandis' => 'http://www.ddegrandis.com/blog',
                'Snipe.net' => 'http://www.snipe.net/',
                'Liz Keogh' => 'http://lizkeogh.com/',
                'Bratty Readhead' => 'http://blog.brattyredhead.com/',
                'Patrick Debois' => 'http://www.jedi.be/',
                'Chris Read' => 'http://blog.chris-read.net/',
                'Kartar' => 'http://www.kartar.net/',
                'Morethanseven' => 'http://www.morethanseven.net/',            #+
                'blog dot lusis' => 'http://blog.lusis.org/blog/archives'      #+
              }

  class << self
    def create_files
      BLOG_LIST.each_key do |file_name|
        safe_name = file_name.gsub(' ', '_').gsub('.', '_').downcase
        instance_variable_set("@#{safe_name}_database", (File.new("#{Dir.pwd}/corpuses/#{safe_name}.txt", 'w') unless File.exist?("#{Dir.pwd}/corpuses/#{safe_name}.txt")))
      end
    end
  end

  Parser.create_files
  fetcher = Mechanize.new

  blog_dot_lusis_main = fetcher.get(BLOG_LIST['blog dot lusis'])
  fetcher.page.links_with(href: /.*\/20.*/).each do |link|
    p link
    link.click
    fetcher.page.search('//*[@id="content"]/div/article/div/p').each do |paragraph|
      @blog_dot_lusis_database << paragraph.content
    end
  end

  morethanseven_main = fetcher.get(BLOG_LIST['Morethanseven'])
  fetcher.page.links_with(href: /.*\/20.*/).each do |link|
    p link
    link.click
    fetcher.page.search('//*[@id="content"]/div/article/div/p').each do |paragraph|
      @morethanseven_database << paragraph.content
    end
  end

end
