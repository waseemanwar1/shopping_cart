namespace :import_products do
  desc 'Import products'
  task import_products_form_csv: :environment do
    data_file_path = 'public/MOCK_DATA.csv'
    if File.exist?(data_file_path)
      puts "\nImporting products\n"
      header = CSV.open(data_file_path).to_a.first
      CSV.foreach(data_file_path, headers: true) do |row|
        row_hash = {}
        header.each_with_index do |field, _index|
          row_hash[field.to_s.to_sym] = row[header.index(field.to_s)]
        end

        path = File.join(Rails.root.to_s, "/public/products_images/#{row_hash[:image]}") if row_hash[:image].present?
        file = File.open(path)
        product = Product.find_or_initialize_by(name: row_hash[:name])
        product.image = file
        product.name = row_hash[:name]
        product.price = row_hash[:price]
        product.quantity = row_hash[:quantity]

        product.save!
      end
    else
      puts "\n Couldn't load file from . Check if file has been placed on specified path\n"
    end
  end
end