require 'crawley'

#Example implementation of the DSL using the full spectrum of the
#possibilities
crawl "http://pypi.python.org/pypi/cilantro/0.9b4" do #Required
  max_depth 2                     #Optional: defaults in 0
  allowed_urls []                 #Optional: defaults in []
  black_list []                   #Optional: defaults in []
  max_concurrency_level 1000      #Optional: defaults in 25
  requests_delay 1000             #Optional: defaults in 100
  requests_deviation 1000         #Optional: defaults in 300
  search_all_urls                 #Optional: defaults in true, 
  #to make it false just call it
  #search_all_urls false   

  debug                           #Optional: defaults in false,
  #to make it true, call it


  login "login_url" do            #Optional: defaults in {}
    username "username"
    password "password"
    login_param "param_name" do
      "value"
    end
    #  ...
  end

  post "an_url" do                #Optional: defaults in {}
    {'param_1' => 'value_1', 'param_2' => 'value_2'}
  end

  post "another_url" do
    {'param_3' => 'value_3'}
  end

  proxy "an_url" do               #Optional: defaults to nothing
    proxy_username "username"
    proxy_password "password"
    proxy_port 80 
  end

  table "MY_TABLE" do             #Required
    field "MY_FIELD_0" do         #Required
      field_mapping_action { |e| e.lower }          #Optional
      "/html/body/div[5]/div/div/div[3]/ul/li/span"
    end

    field "MY_FIELD_1" do
      "/html/body/div[5]/div/div/div[3]/ul/li[3]/span"
    end

    field "MY_FIELD_2" do
      "/html/body/div[5]/div/div/div[3]/ul/li[4]/span"
    end
  end
end
