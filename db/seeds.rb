require 'csv'
   Rake::Task['db:drop'].execute
   Rake::Task['db:create'].execute
   Rake::Task['db:migrate'].execute
   puts "with CSV files"
   data = {
     'Merchant' => 'merchants.csv',
     'Customer' => 'customers.csv',
     'Invoice' => 'invoices.csv',
     'Item' => 'items.csv',
     'Transaction' => 'transactions.csv',
     'InvoiceItem' => 'invoice_items.csv',
   }
   data.keys.each do |model|
     klass = model.classify.constantize
     klass.delete_all
     puts "injecting CSV data for #{model}"
     payload = CSV.read("db/csv_data/#{data[model]}", headers: true)
     payload.each do |row|
       # require 'pry';binding.pry
       model_data = row.to_h
       if model_data.has_key? 'unit_price'
         model_data['unit_price'] = model_data['unit_price'].to_f / 100
       end
       klass.create!(model_data)
     end
     puts "finished, #{klass.count} rows in the database"
   end
   ActiveRecord::Base.connection.tables.each do |t|
     ActiveRecord::Base.connection.reset_pk_sequence!(t)
   end
