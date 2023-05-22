class HomeController<ApplicationController

def login
  render({:template=>"home/login.html.erb"})
end

def signup
  render({:template=>"home/signup.html.erb"})
end

def home
  render({:template=>"home/home.html.erb"})
end

def results
  @location = params.fetch(:input_location)

  require "openai"

openai_client = OpenAI::Client.new(
    access_token: ENV.fetch("CHAT_KEY"),
    request_timeout: 240
)
response = openai_client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [
          { role: "system", content: "Provide the best hipster coffee shops as of your data cut-off in a sample JSON based on the location provided by the user. Output will look like this {:name, :address, :latitude, :longitude, :rating}. It is ok that it is not real time. Give me no output except the JSON"},
          { role: "user", content: @location }], # Required.
        temperature: 0,
    })

    message = response.fetch("choices").at(0).fetch("message").fetch("content")
    
    output = JSON.parse(message)

    @array = output.fetch("coffee_shops")

  render({:template=>"home/results.html.erb"})
end

def playground
  @my_array = {"id"=>1, "name"=>"Intelligentsia Coffee", "address"=>"53 E Randolph St, Chicago, IL 60601", "latitude"=>41.8841, "longitude"=>-87.6259, "rating"=>4.6}, {"id"=>2,"name"=>"Hero Coffee Bar", "address"=>"22 E Jackson Blvd, Chicago, IL 60604", "latitude"=>41.8789, "longitude"=>-87.6254, "rating"=>4.5}, {"id"=>3,"name"=>"La Colombe Coffee", "address"=>"955 W Randolph St, Chicago, IL 60607", "latitude"=>41.8849, "longitude"=>-87.6512, "rating"=>4.5}, {"id"=>4,"name"=>"Sawada Coffee", "address"=>"112 N Green St, Chicago, IL 60607", "latitude"=>41.8837, "longitude"=>-87.6489, "rating"=>4.5}, {"id"=>5,"name"=>"Caffe Streets", "address"=>"1750 W Division St, Chicago, IL 60622", "latitude"=>41.9035, "longitude"=>-87.6725, "rating"=>4.4}

  @my_location = "60601"

  render({:template=>"home/playground.html.erb"})
end

end
