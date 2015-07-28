module OrderImporter
  module Convertible

    # Requirement is to return mm-dd-yyyy format
    #
    # BUT
    # Return date format %Y-%m-%d to be stored in database
    # for avoiding the format not match database localisation
    #
    # Render i18n in view for both HTML and JSON format
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
      separator    = curreny_string[curreny_string.length-3]
      major, minor = '', ''

      case separator
      when ',','.'
        major, minor = curreny_string[0..curreny_string.length-4], curreny_string[curreny_string.length-2..curreny_string.length-1]
        if major[/(,|\.)/]
          major.gsub!('.',',')
        else
          major = add_separator(major)
        end
        "#{major}.#{minor}"
      else
        if curreny_string[/(,|\.)/]
          curreny_string
        else
          "#{add_separator(curreny_string)}.00"
        end
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

    def add_separator(str)
      reversed = str.reverse
      result   = ''
      for i in (0..reversed.length-1) do
        result << reversed[i]
        result << ',' if (i+1) % 3 == 0
      end
      result.reverse
    end

  end
end