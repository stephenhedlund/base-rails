class HomeController<ApplicationController

def home
  render({:template=>"home/home.html.erb"})
end

def results
  location = params.fetch(:input_location)

  require "openai"

openai_client = OpenAI::Client.new(
    access_token: ENV.fetch("CHAT_KEY"),
    request_timeout: 240
)
response = openai_client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [
          { role: "system", content: "Provide the best hipster coffee shops in JSON based on the location provided by the user. Output will look like this {:name, :address, :latitude, :longitude, :rating}. It's ok that it's not real time data. Give me nothing but the JSON."},
          { role: "user", content: location }], # Required.
        temperature: 0.1,
    })

    message = response.fetch("choices").at(0).fetch("message").fetch("content")
    
    output = JSON.parse(message)

    @array = output.fetch("coffee_shops")

  render({:template=>"home/results.html.erb"})
end

end
