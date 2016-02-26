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
> # Set API key directly:
> synthetics = Synthetics.new('<YOUR-API-KEY>')

> # Set API key via environment variable:
> ENV['SYNTHETICS_API_KEY'] = 'YOUR-API-KEY'
> synthetics = Synthetics.new
```

### Locations

List locations:

```ruby
> synthetics.locations.list
[
  {:private=>false, :name=>"AWS_US_EAST_1", :label=>"Washington, DC, USA"},
  ...
]
```

### Monitors

List monitors:

```ruby
> synthetics.monitors.list
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

Create monitor:

```ruby
> synthetics.monitors.create(
> ...   name: 'Google Monitor',
> ...   frequency: 15,
> ...   uri: 'https://google.com',
> ...   locations: %w(AWS_US_WEST_1),
> ...   type: 'simple'
> ... )
nil
```

### Monitor

These examples assume you have a valid monitor UUID, such as:

```ruby
> uuid = 'SOME-VAILD-UUID'
```

Show monitor:

```ruby
> synthetics.monitor(uuid).show
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
  :api_version => "0.2.2"
}
```

Update monitor:

```ruby
> synthetics.monitor(uuid).update(
> ...   name: 'Google Monitor',
> ...   frequency: 30,
> ...   uri: 'https://google.com',
> ...   locations: %w(AWS_US_WEST_1),
> ...   type: 'simple'
> ... )

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

Update monitor script:

```ruby
> synthetics.monitor(uuid).update_script('var test = function() {};')
nil
```

Destroy monitor:

```ruby
> synthetics.monitor(uuid).destroy
nil
```

### Labels


List labels:

```ruby
> synthetics.labels.list
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
> label = 'sample:label'
```

Show monitors for a label:

```ruby
> synthetics.label(label).monitors
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

Attach a label to a monitor:

```ruby
> synthetics.label(label).attach(uuid)
nil
```

Remove a label from a monitor:

```ruby
> synthetics.label(label).remove(uuid)
nil
```
