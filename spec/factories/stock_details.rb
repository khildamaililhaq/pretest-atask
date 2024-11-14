FactoryBot.define do
  factory :stock_detail do
    symbol { "MyString" }
    identifier { "MyString" }
    open { 1.5 }
    day_high { 1.5 }
    day_low { 1.5 }
    last_price { 1.5 }
    previous_close { 1.5 }
    change { 1.5 }
    p_change { 1.5 }
    year_high { 1.5 }
    year_low { 1.5 }
    total_traded_value { 1.5 }
    total_traded_volume { 1.5 }
    last_update_time { "2024-11-08 15:05:12" }
    per_change_30d { 1.5 }
    per_change_365d { 1.5 }
  end
end
