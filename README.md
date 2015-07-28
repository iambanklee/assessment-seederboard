## Exampl.biz Commerce Challenge

This is a sample project which implemets [Exampl.biz Commerce Challenge](https://github.com/iambanklee/coding_challenge_1)

## Structure
1. OrderImporter is the single interface to import both .csv or .txt format order
    1. OrderImporter::CsvImporter implemets how .csv format orders are imported
    1. OrderImporter::TxtImporter implemets how .txt format orders are imported
2. OrderImporter::Convertible encapsulates the data and currency converting code shared between CsvImporter and TxtImporter
3. OrderImporter::OrderCalculator is handling exchange rate checking and calculating the order value based on its local currency code and the historical exchange rate

##
### 1. Importing orders
#### Usage
```ruby
# Import
rake order:import

# Reset order table
rake order:reset

# Reload all orders (will Reset orders table first and then import orders again)
rake order:import
```
### 2. Index page of orders
Click to view all [orders](http://seederboard.banklee.co.uk) IN HTML

Click to view all [orders](http://seederboard.banklee.co.uk/orders.json) in JSON

### 3. Show Order
Click to view one [order](http://seederboard.banklee.co.uk/orders/1) IN HTML

Click to view one [orders](http://seederboard.banklee.co.uk/orders/1.json) in JSON

### 4. Historical exchange rate
Historical exchange rate is handled by [OpenExchangeRateChecker](https://github.com/iambanklee/open_exchange_rate_checker) which has details