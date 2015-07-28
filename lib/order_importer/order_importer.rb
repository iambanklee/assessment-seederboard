module OrderImporter
  DATA_FOLDER = "#{Rails.root}/data/*"

  def self.import
    file_queue.each do |file_path|
      File.open(file_path, "r") do |file|
        puts "importing #{file_path}"
        file_type = File.extname(file)
        case file_type
        when '.csv'
          OrderImporter::CsvImporter.import(file)
        when '.txt'
          OrderImporter::TxtImporter.import(file)
        else
          raise StandardError, "File type not support"
        end
        puts "finished  #{file_path}"
      end
    end
  end

  def self.file_queue
    Dir.glob(DATA_FOLDER).select { |file| not File.directory?(file) }
  end
end