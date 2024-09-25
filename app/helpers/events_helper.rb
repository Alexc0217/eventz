module EventsHelper
  def price(event)
    if event.free?
      "Free"
    else
      number_to_currency(event.price)
    end
  end

  def day_and_time(event)
    event.starts_at.strftime("%B %d %I:%M %P")
  end
end
