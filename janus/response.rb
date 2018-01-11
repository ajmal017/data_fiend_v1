require './helper'

module Response
  def roads_paved
    [200, content_type, message(:paved) ]
  end

  def thread_created    [200, content_type, message(:thread_created)]
  end

  def invalid
    [400, content_type, message(:invalid)]
  end
  
  def internal_error
    [500, content_type, message(:internal_error)]
  end

  def message_sent
    [200, content_type, message(:sent)]
  end

  private

    def content_type
      {'Content-Type' => 'application/json'}
    end

    def message(mes)
      case mes
      when :paved
        "roads paved"
      when :invalid
        "invalid submission"
      when :thread_created
        "thread successfully created"
      when :internal_error
        "internal service error"
      when :sent
        "message added to queue"
      end
    end

end
