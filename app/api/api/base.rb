module API
  class Base
    prefix 'api'

    rescue_from :all, :backtrace => true

    # Rescue from errors
    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(message: [e.message], status: 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error_response(message: [e.message], status: 422)
    end


    rescue_from :all do |e|
      p "ERROR:: (#{e.class.name}) - #{e.message}"
      e.backtrace.take(10).each_with_index do |msg, index|
        p "#{index} - #{msg}"
      end
      Raven.capture_exception(e)
      error_response({ message: ["(#{e.class.name}) - #{e.message}"], backtrace: e.backtrace})
    end

  mount API::V1::Base

  end
end
