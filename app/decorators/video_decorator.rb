class VideoDecorator < Draper::Decorator

  # allows us to pass in all Video methods, not just the decorator methods
  delegate_all

  def rating
    object.rating.present? ? "#{object.rating}/5.0" : "N/A"
  end

end