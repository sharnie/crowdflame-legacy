module OfferHelper
  def delivery_days
    days = []
    [1, 2, 3, 4, 5].each do |days_count|
      if days_count <= 1
        days << {count: days_count, name: "#{days_count} Day"}
      else
        days << {count: days_count, name: "#{days_count} Days"}
      end
    end
    days.map { |day| [ day[:name], day[:count] ] }
  end

  def offer_price
    prices = []
    [5].each do |price|
      prices << {amount: price, name: "$#{price}"}
    end
    prices.map { |price| [ price[:name], price[:amount] ] }
  end

  def socialconnection_options
    current_user.socialconnections.map do |connection|
      [connection[:username], connection[:id]]
    end
  end
end