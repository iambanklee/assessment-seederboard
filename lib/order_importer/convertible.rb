module OrderImporter
  module Convertible

    # Use date format %Y-%m-%d to be stored in database
    # For avoiding the format not match database localisation
    def convert_date(date_string)
      converted_date = nil
      date_formats.each do |date_format|
        begin
          converted_date = Date.strptime(date_string, date_format)
          break
        rescue ArgumentError
          next
        end
      end
      converted_date.strftime("%Y-%m-%d")
    end

    def curreny_to_gbp(curreny_string)
      separator = curreny_string[curreny_string.length-3]
      if separator == ','
        major, minor = curreny_string[0..curreny_string.length-4], curreny_string[curreny_string.length-2..curreny_string.length-1]
        major.gsub!('.',',')
        "#{major}.#{minor}"
      else
        curreny_string
      end
    end

    private

    # Define the converting order of date format
    # A date 4/11/2015 will use mm/dd/yyyy rule which matchs the first rule
    def date_formats
      [
        '%m/%d/%Y', #'mm/dd/yyyy',
        '%m-%d-%Y', #'mm-dd-yyyy',
        '%m-%d-%y', #'mm-dd-yy',
        '%d/%m/%Y', #'dd/mm/yyyy',
        '%d-%m-%Y', #'dd-mm-yyyy',
        '%d-%m-%y', #'dd-mm-yy',
        '%a, %d %b %Y' #strftime, e.g. 'Sat, 10 Nov 2007'
      ]
    end

  end
end