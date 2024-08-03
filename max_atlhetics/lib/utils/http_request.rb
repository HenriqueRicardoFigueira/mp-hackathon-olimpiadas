module Utils
  class HttpRequest
    def get(url, options = {})
      request :get, url, options
    end

    def post(url, options = {})
      request :post, url, options
    end

    def put(url, options = {})
      request :put, url, options
    end

    def patch(url, options = {})
      request :patch, url, options
    end

    private

    def request(method, url, options = {})
      HTTParty.public_send(method, url, options)
    end
  end
end
