require 'nokogiri'
require 'mechanize'
require 'open-uri'

class Parser
  include Nokogiri

  # list heavily influenced by
  # http://www.stackdriver.com/top-devops-influencers-blogs-follow/

  @blog_list = { 'Andrew Hay' => 'http://www.andrewhay.ca/',
                 # ^ Scrape all '/p', click "Older Posts"
                 'Scalable Startups' => 'http://www.iheavy.com/blog/',
                 # ^ Scrape all /div/p, then click "Older posts"
                 'Kevin Behr' => 'http://www.kevinbehr.com/kevins-blog.html'
                 # ^ keep clickin on << Previous till the end of time
               }

  @blog_list_other = { 'Agile Sysadmin' => 'http://www.agilesysadmin.net/',
                       # ^ inconsistent links to blog posts :(
                     }

  @blog_list_more_next = { 'Socialized Software' => 'http://socializedsoftware.com/',
                            # ^ Click "More", then "next"
                           'Kitchen Soap' => 'http://www.kitchensoap.com/',
                           # ^ "Continue reading...", then "Next Page" x10,
                           # then /div/div/p
                           'Marten Mickos' => 'https://www.eucalyptus.com/blog/11',
                           # ^ Click "Read more", then "next"
                           'Gene Kim' => 'http://itrevolution.com/devops-blog/',
                           # ^ "Read More…", "Older Entries", scrape
                           # /html/body/div/div/div/p
                           'Patrick Debois' => 'http://www.jedi.be/'
                           # ^ scrape all p's, click "next"
                         }

  @blog_list_wordpress = { 'Goat Can' => 'http://goatcan.wordpress.com/',
                           'Liz Keogh' => 'http://lizkeogh.com/',
                           'Test Obsessed' => 'http://testobsessed.com/',
                           'Build Doctor' => 'http://build-doctor.com/',
                           'Chris Read' => 'http://blog.chris-read.net/'
                         }

  @blog_list_blogpost = { 'TechnoCalifornia' => 'http://technocalifornia.blogspot.com/',
                          'Adrian Cockcroft' => 'http://perfcap.blogspot.com/'
                        }

  @blog_post_simple = { 'Dominica DeGrandis' => 'http://www.ddegrandis.com/blog',
                        # one-page blog, scrape all /p
                        'Snipe.net' => 'http://www.snipe.net/',
                        # one-page blog, /html/body/div/div/div/div
                        'DevOpsGuys' => 'http://blog.devopsguys.com/',
                        # ^ One-page with endless scrolling, scrape all ps and lis
                      }

  # DONE! :)
  @blog_list_one_page = { 'Morethanseven' => 'http://www.morethanseven.net/',
                          'blog dot lusis' => 'http://blog.lusis.org/blog/archives',
                          'Bratty Readhead' => 'http://blog.brattyredhead.com/blog/archives',
                          'Kartar' => 'http://www.kartar.net/'
                        }

  @fetcher = Mechanize.new
  @fetcher.redirect_ok

  class << self
    def scrape_blog_list_one_page
      @blog_list_one_page.each_key do |blog|
        safe_name = blog.gsub(' ', '_').gsub('.', '_').downcase
        @corpus = File.new("#{Dir.pwd}/corpuses/#{safe_name}.txt", 'w')
        @fetcher.get(@blog_list_one_page[blog])

        @fetcher.page.links_with(href: /.*\/20.*/).each do |link|
          begin
            p link
            link.click
            @fetcher.page.search((
              if blog == 'Kartar'
                "//*[@id='main']/article/div/div/p"
              else
                "//*[@id='content']/div/article/div/p"
              end)).each do |paragraph|
              @corpus << "#{paragraph.content}\n"
            end
          rescue Mechanize::RedirectLimitReachedError
            next
          end
        end
      end
    end
  end

  Parser.scrape_blog_list_one_page

end
