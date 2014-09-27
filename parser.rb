require 'nokogiri'

class Parser
  include Nokogiri
  # list heavily influenced by
  # http://www.stackdriver.com/top-devops-influencers-blogs-follow/
  BLOG_LIST = { 'Andrew Hay' => 'http://www.andrewhay.ca/',
                'Goat Can' => 'http://goatcan.wordpress.com/',
                'Gene Kim' => 'http://itrevolution.com/devops-blog/',
                'ScriptRock' => 'http://scriptrock.com/blog/',
                'DevOpsGuys' => 'http://blog.devopsguys.com/',
                'Adrian Cockcroft' => 'http://perfcap.blogspot.com/',
                'Kitchen Soap' => 'http://www.kitchensoap.com/',
                'Scalable Startups' => 'http://www.iheavy.com/blog/',
                'Socialized Software' => 'http://socializedsoftware.com/',
                'Marten Mickos' => 'https://www.eucalyptus.com/blog/11',
                'Agile Sysadmin' => 'http://www.agilesysadmin.net/',
                'Kevin Behr' => 'http://www.kevinbehr.com/',
                'Build Doctor' => 'http://build-doctor.com/',
                'TechnoCalifornia' => 'http://technocalifornia.blogspot.com/',
                'Test Obsessed' => 'http://testobsessed.com/',
                'Dominica DeGrandis' => 'http://www.ddegrandis.com/blog',
                'Snipe.net' => 'http://www.snipe.net/',
                'Liz Keogh' => 'http://lizkeogh.com/',
                'Bratty Readhead' => 'http://blog.brattyredhead.com/',
                'Patrick Debois' => 'http://www.jedi.be/',
                'Chris Read' => 'http://blog.chris-read.net/',
                'Kartar' => 'http://www.kartar.net/',
                'Morethanseven' => 'http://www.morethanseven.net/',
                'blog dot lusis' => 'http://blog.lusis.org/'
              }
end
