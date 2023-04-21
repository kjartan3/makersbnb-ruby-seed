Class names:

User & UserRepository
Space & SpaceRepository
Booking & BookingRepository

# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method: GET
  * the path /requests
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

  * the path /requests/view
   * the HTTP method: GET
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->

<html>
  <head></head>
  <body>
    <h1>Requests</h1>
    <div>Requests I've made</div>
    <div>Requests I've received</div>
  </body>
</html>
```

```html
<!-- EXAMPLE -->
<!-- Response when there are no requests: 200 OK -->

<html>
  <head></head>
  <body>
    <h1>Requests</h1>
    <div>Nothing to show right now.</div>
    <div>Nothing to show right now.</div>
  </body>
</html>

```html
<!-- EXAMPLE -->
<!-- Response when there are no requests made but there are req received: 200 OK -->

<html>
  <head></head>
  <body>
    <h1>Requests</h1>
    <div>Nothing to show right now.</div>
    <div>Requests I've received</div>
  </body>
</html>
```
```html
<!-- EXAMPLE -->
<!-- Response when there are no requests received but there are req made: 200 OK -->

<html>
  <head></head>
  <body>
    <h1>Requests</h1>
    <div>Requests I've made</div>
    <div>Nothing to show right now.</div>
  </body>
</html>

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /requests

# Expected response:

Response for 200 OK
```

```
# Request:

GET /requests/view

# Expected response:

Response for 200 OK
```

# Request:

POST /requests/view

# Expected response:

Response for 200 OK

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /requests" do
    it 'returns 200 OK' do
      
      response = get('/requests')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Requests</h1>')
      expect(response.body).to include('<div>Requests I've made</div>')
      expect(response.body).to include('<div>Requests I've received</div>')
    end
  end

  context "GET /requests/view" do
    it "returns the requests seperately" do
      response = get('/requests')

      expect(response.status).to eq(200)

    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->