require_relative 'time_format'
class App
  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    case @request.path_info
      when '/time'
        @result = TimeFormat.new(@request.params['format']).format
        @result.instance_of?(String) ? success : failed
      else
        unknown_handler
    end
  end

  private

  def success
    @response.status = 200
    @response.headers['Content-Type'] = 'text/plain'
    @response.write "#{@result}\n"
    @response.finish
  end

  def failed
    @response.status = 400
    @response.headers['Content-Type'] = 'text/plain'
    @response.write "Unknown time format #{@result}\n"
    @response.finish
  end

  def unknown_handler
    @response.status = 404
    @response.headers['Content-Type'] = 'text/plain'
    @response.write "Not found\n"
    @response.finish
  end

end

