class MyApp
  def call(env)
    [401, {"Content-Type" => "text/html"}, [""]]
  end
end
