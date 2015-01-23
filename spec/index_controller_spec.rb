require_relative 'spec_helper'

describe "index_controller" do
  describe "GET /" do
    it 'renders a successful status' do
      # Given
      # When
      get '/'
      # Then
      expect(last_response.status).to eq(200)
    end

    it "renders a list of urls" do
      # Given
      Url.create(address: "http://abc.com")
      puts '-'*50
      # When
      get '/'
      # Then
      expect(last_response.body).to include("http://abc.com")
    end
  end

  describe "POST /urls" do
    it 'creates a new url' do
      # Given
      Url.destroy_all
      # When
      # Then
      expect{
        post "/urls", input: {address: "http://abc.com"}
        # post("/urls",{ input: {address: "http://abc.com"}})
        }.to change {Url.count}
      end
    end

    describe "GET /:short_url" do
      describe "if the URL exists" do
        it 'redirects to the full URL' do
          # Given
          url = Url.create(address: "http://cnn.com")
          # When
          get "/#{url.short_url}"
          # Then
          expect(last_response.status).to eq(200)
        end
      end
    end

  end

