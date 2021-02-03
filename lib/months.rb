require 'date'

class Months
  def self.days_to_months
    # Do not touch!
    {
      "January" => 31,
      "February" => ::Date.gregorian_leap?(Time.now.year) ? 29 : 28,
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

  def self.average()
    # Implement me!
  end

  def self.valid?(month)
    # Do not touch!
    days_to_months[month.name] != nil
  end

  def name
    # Do not touch!
  end
end
