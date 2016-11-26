json.extract! bill, :id, :event, :date, :location, :total_amount, :splits_in, :created_at, :updated_at
json.url bill_url(bill, format: :json)