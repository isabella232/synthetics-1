# Synthetics

Synthetics is a rubygem that interfaces with New Relic Synthetics' [HTTP API](https://docs.newrelic.com/docs/apis/synthetics-rest-api/monitor-examples/manage-synthetics-monitors-via-rest-api).
It can be used to manage monitors and labels programatically.
The above link is useful for finding the possible options that can be passed to each method, particularly creating and updating monitors.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'synthetics'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install synthetics
```

## Usage

All interaction with the API starts by creating an API client.
The client requires an admin API key, which can be generated in the Web UI.
Once you have your API key, there are two ways you can pass it to the client:

```ruby
# Set API key directly:
synthetics = Synthetics.new('<YOUR-API-KEY>')

# Set API key via environment variable:
ENV['SYNTHETICS_API_KEY'] = 'YOUR-API-KEY'
synthetics = Synthetics.new
```
### Debugging
This gem uses [Excon](https://github.com/excon/excon) to make the requests. To enable debug output
create an environment variable:

```bash
export EXCON_DEBUG=true
``` 

### Locations

Listing locations requires using API v1 which this gem does not support. 


### Monitors

#### List monitors.
 
Note that by default New Relic will only return up to 20 records.

```ruby
synthetics.monitors.list
```
Response:
```ruby
{
  :monitors => [
    {
      :id => "SOME-VALID-UUID",
      :name => "Ping Google",
      :type => "SIMPLE",
      :frequency => 1440,
      :uri => "https://google.com",
      :locations => ["AWS_US_EAST_1", "AWS_EU_WEST_1"],
      :status => "ENABLED",
      :sla_threshold => 7.0,
      :modified_at => "2016-02-26T15:10:58.515+0000",
      :created_at => "2016-02-26T15:10:58.515+0000",
      :user_id => 123,
      :api_version => "0.2.2",
      :options => {
              :validation_string => 'Search',
              :verify_s_s_l => true,
              :bypass_h_e_a_d_request => true,
              :treat_redirect_as_failure => true
          }
    }
  ],
  :count => 1
}
```

#### List monitors Paged
New Relic will only return 20 records at a time. To get more records than that do something
like this:

```ruby
next_link = nil
begin
  result = synthetics.monitors.list_paginated(25, next_link) # results limit, next results link
  next_link = result[:links]["next"]

  result[:monitors].each do |monitor|
    # do work here
  end

end while ! next_link.nil?
```
The results will be in the same format as the non-paged results. The maximum results for each request
is 100.

If next_link is not nil, it will override the offset and results limit arguments.

#### Create monitor

```ruby
synthetics.monitors.create(
   name: 'Google Monitor', # string [required],
   frequency: 15, # integer (minutes) [required, must be one of 1, 5, 10, 15, 30, 60, 360, 720, or 1440],
   uri: 'https://google.com', # string [required for SIMPLE and BROWSER type],
   locations: %w(AWS_US_WEST_1), # array of strings [at least one required],
   type: 'simple', # string (SIMPLE, BROWSER, SCRIPT_API, SCRIPT_BROWSER) [required],
   slaThreshold: 15, # double, required response time in seconds
    options: {
        validationString: 'Search', # string [only valid for SIMPLE and BROWSER types],
        verifySSL: true, # boolean (true, false) [only valid for SIMPLE and BROWSER types],
        bypassHEADRequest: true, #boolean (true, false) [only valid for SIMPLE types],
        treatRedirectAsFailure: true # boolean (true, false) [only valid for SIMPLE types]
    }
)
```
The reponse will be nil. 

### Monitor

These examples assume you have a valid monitor UUID, such as:

```ruby
uuid = 'SOME-VAILD-UUID'
```

#### Show monitor
Note that the options keys returned here are not quite the same as the keys used
when creating a new monitor.

```ruby
synthetics.monitor(uuid).show
```

Result:
```ruby
{
  :id => "SOME-VALID-UUID",
  :name => "Ping Google",
  :type => "SIMPLE",
  :frequency => 15,
  :uri => "https://google.com",
  :locations => ["AWS_US_EAST_1", "AWS_EU_WEST_1"],
  :status => "ENABLED",
  :sla_threshold => 7.0,
  :modified_at => "2016-02-26T15:10:58.515+0000",
  :created_at => "2016-02-26T15:10:58.515+0000",
  :user_id => 123,
  :api_version => "0.5.1",
  :options => {
              :validation_string => "Search",
              :verify_s_s_l => true,
              :bypass_h_e_a_d_request => true,
              :treat_redirect_as_failure => true  
              }
```


#### Update monitor
Updating a monitor requires submitting all the same info as if you were creating it from scratch.
```ruby
synthetics.monitor(uuid).update(
   name: 'Google Monitor',
   frequency: 30,
   uri: 'https://google.com',
   locations: %w(AWS_US_WEST_1),
   type: 'simple',
    options: {
        validationString: 'Search',
        verifySSL: true,
        bypassHEADRequest: true,
        treatRedirectAsFailure: true 
   }
)
```
Result:
```ruby
{
  :id => "SOME-VALID-UUID",
  :name => "Ping Google",
  :type => "SIMPLE",
  :frequency => 30,
  :uri => "https://google.com",
  :locations => ["AWS_US_EAST_1", "AWS_EU_WEST_1"],
  :status => "ENABLED",
  :sla_threshold => 7.0,
  :modified_at => "2016-02-26T15:10:58.515+0000",
  :created_at => "2016-02-26T15:10:58.515+0000",
  :user_id => 123,
  :api_version => "0.2.2"
}
```

#### Update monitor script

```ruby
synthetics.monitor(uuid).update_script('var test = function() {};')
```
Result will be nil.


Destroy monitor:

```ruby
> synthetics.monitor(uuid).destroy
```
Result will be nil.

### Labels

#### List labels

```ruby
synthetics.labels.list
```

Result:
```ruby
{
  :labels => [
    {
      :type => 'sha',
      :value => '8ace32a'
    }
  ],
  :count => 1
}
```

### Label

These examples assume you have a valid label, such as:

```ruby
label = 'sample:label'
```

Show monitors for a label:

```ruby
synthetics.label(label).monitors
```
Result:
```ruby
{
  :monitors => [
    {
      :id => "SOME-VALID-UUID",
      :name => "Ping Google",
      :type => "SIMPLE",
      :frequency => 1440,
      :uri => "https://google.com",
      :locations => ["AWS_US_EAST_1", "AWS_EU_WEST_1"],
      :status => "ENABLED",
      :sla_threshold => 7.0,
      :modified_at => "2016-02-26T15:10:58.515+0000",
      :created_at => "2016-02-26T15:10:58.515+0000",
      :user_id => 123,
      :api_version => "0.2.2"
    }
  ],
  :count => 1
}
```

#### Attach a label to a monitor

```ruby
synthetics.label(label).attach(uuid)
```
Result will be nil.


#### Remove a label from a monitor:

```ruby
synthetics.label(label).remove(uuid)
```
Result will be nil.
