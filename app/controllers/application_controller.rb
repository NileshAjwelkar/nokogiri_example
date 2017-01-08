class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Define the Entry object
  class Entry
  	attr_reader :title
    attr_reader :link

    def initialize(title, link)
	  # Rails.logger.info "\n\n === #{title.inspect} || #{link.inspect} === \n\n"

      @title = title
      # Rails.logger.info "\n\n === :t: #{@title.inspect} === \n\n"
      @link = link
      # Rails.logger.info "\n\n === :l: #{@link.inspect} === \n\n"
    end

  end

  def scrape_reddit
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.reddit.com/"))

    entries = doc.css('.entry')
    @entriesArray = []
    entries.each do |entry|
      logger.info "\n\n === #{entry.css.inspect} === \n\n"	
      title = entry.css('p.title>a').text
      link = entry.css('p.title>a')[0]['href']
      temp = Entry.new(title, link)
      # logger.info "\n\n === #{temp.inspect} === \n\n"

      @entriesArray << temp
    end

    
    render template: 'scrape_reddit'
  end
end
