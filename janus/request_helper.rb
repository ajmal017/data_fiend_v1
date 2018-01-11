class RequestHelper

  def initialize(args)
    @url = args[:url]
    @headers = args[:headers]
    @body = args[:body]
    @connection = create_connection
  end

  def post
    connection.post do |conn|
      conn.body = body
    end
  end

  def get
    connection.get do |conn|
      conn.body = body
    end
  end

  private
    attr_reader :connection,
                :headers,
                :url,
                :body

    def create_connection
      Faraday.new('https://' + YamlParser.read('HOST') + "/" + url) do |f|
        headers.each do |key, val|
          f.headers[key] = val
        end
        f.adapter Faraday.default_adapter
      end
    end
end
