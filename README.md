##!Rails

!Rails is a model-views-controller (MVC) web application framework written in Ruby and inspired by Ruby on Rails that accepts incoming HTTP requests and generates suitable responses. It employs Rack to create a server and utilizes a custom Router to evaluate inbound requests made to the server and map each request to an appropriate controller. Within the controller, a series of methods is then applied to the request in order to yield a custom response for each request.

The `Router` evaluates incoming requests and directs them to the appropriate controller:
```Ruby
[:get, :post, :put, :delete].each do |http_method|
  define_method(http_method) do |pattern, controller_class, action_name|
    add_route(
    pattern,
    http_method,
    controller_class,
    action_name)
  end
end
```
The controllers can generate appropriate responses by utilizing a series of methods made available through the extension of the `ControllerBase` class, including:

- `redirect_to(url)`: redirects to the given url
- `render(template_name)`: analyzes templates using ERB and passes them to `render_content`.
- `render_content(content, content_type)`: takes the rendered html views from `render(template_name)` and renders the content in the format of the content type

```Ruby
def render_content(content, content_type)
  raise if already_built_response?
  res.write(content)
  res['Content-Type'] = content_type
  self.already_built_response = true
  session.store_session(res)
end
```

Features to implement:
- demo
