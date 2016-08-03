Ransack.configure do |config|

  config.add_predicate "beginning_of_day_gteq",
    arel_predicate: "gteq",
    formatter: proc {|v| v.to_date.beginning_of_day},
    validator: proc {|v| v.present?},
    type: :string

  config.add_predicate "end_of_day_lt",
    arel_predicate: "lt",
    formatter: proc {|v| v.to_date.end_of_day},
    validator: proc {|v| v.present?},
    type: :string
end
