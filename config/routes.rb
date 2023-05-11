Rails.application.routes.draw do
get("/", {:controller=> "home", :action=>"home"})

get("/results", {:controller=> "home", :action=> "results"})


end
