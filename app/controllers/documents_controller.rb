class DocumentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def submit
    Document.create submit_params
  end

  def search
    @query = search_query
    @results = Document.search(search_query).records
    @tags = tags
  end

  def index
    @tags = tags
  end

  private

  def submit_params
    params.require(:document).permit(
        :url, 
        :source, 
        :title, 
        :publish_date, 
        :keywords,
        :summary,
        :body,
        :doctype
      )
  end

  def search_query
    params.require(:q)
  end

  def tags
    if @results
      tally = {}
      @results.collect{|r| r.keywords.split(',').map(&:strip) }.flatten.each do |tag|
        if tally[tag].nil?
          tally[tag] = 0
        else
          tally[tag] += 1
        end
      end
      tally.sort_by{|_key, value| value}.reverse[0,6].collect(&:first)
    else
      ['dual extruder', 'polypropylene', 'multitool', 'thermoplastic', 'tool changer', 'scraper']
    end
  end

  module Enumerable
    def tally_by(&function)
      function ||= -> v { v }
      
      each_with_object(Hash.new(0)) do |value, hash|
        hash[function.call(value)] += 1
      end
    end
    
    def tally
      tally_by(&:itself)
    end
  end
end
