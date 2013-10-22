module CsvExportable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |s|
          csv << s.attributes.values_at(*column_names)
        end
      end
    end
  end
end
