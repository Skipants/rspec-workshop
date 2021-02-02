class Months
  def self.days_in_month
    {
      "January" => 31,
      "February" => Time.days_in_month(2, Time.now.year),
      "March" => 31,
      "April" => 30,
      "May" => 31,
      "June" => 30,
      "July" => 31,
      "August" => 31,
      "September" => 30,
      "October" => 31,
      "November" => 30,
      "December" => 31,
    }
  end

  def self.average(month_1, month_2, month_3)
  end

  def self.correct_name?(month)
    days_in_month[month.name] != nil
  end

  def name
  end
end
