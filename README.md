# NotSoEasyHubspot
Stable: ![stable version](https://img.shields.io/badge/version-1.0.0-green)
Latest: ![latest version](https://img.shields.io/badge/version-1.0.0-yellow)
[![CI](https://github.com/oroth8/not_so_easy_hubspot/actions/workflows/ci.yml/badge.svg)](https://github.com/oroth8/not_so_easy_hubspot/actions/workflows/ci.yml)
[![Code Climate](https://codeclimate.com/github/oroth8/not_so_easy_hubspot/badges/gpa.svg)](https://codeclimate.com/github/oroth8/not_so_easy_hubspot)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c55dfda6142769b8209c/test_coverage)](https://codeclimate.com/github/oroth8/not_so_easy_hubspot/test_coverage)

This is a lightweight wrapper for the Hubspot API. It is designed to be easy to use and to provide a simple setup for the most common use cases.

This gem utilizes the `v3` hubspot-api

## CRM Objects
- [Contacts](#contacts)
- [Deals](#deals)

- [Error Handling](#error-handling)

### Dependencies
- [gem "httparty", "~> 0.21.0"](https://github.com/jnunemaker/httparty)

### Compatibility
- `ruby >= 2.6.10`
- `rails >= 6.0`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'not_so_easy_hubspot'
```

## Usage

Add the following to your `config/initializers/not_so_easy_hubspot.rb` file:

```ruby
NotSoEasyHubspot.config do |c|
  c.access_token = 'YOUR API KEY'
  c.base_url = 'https://api.hubapi.com/'
end
```

### Contacts

Please refrence the [hubspot docs](https://developers.hubspot.com/docs/api/crm/contacts)

```ruby
# Create a contact 
  # required: body 
  # returns: parsed hubspot contact
  NotSoEasyHubspot::Contact.create_contact(properties: { email: '', firstname: '', lastname: '' , etc: ''})

# Update a contact 
# required: contact_id, body
# - contact_id: can be a hubspot contact_id or email
# returns: parsed hubspot contact
  NotSoEasyHubspot::Contact.update_contact(123, properties: { email: '', firstname: '', lastname: '' , etc: ''})

# Get a contact
# required: contact_id
# - contact_id: can be a hubspot contact_id or email
# returns: parsed hubspot contact
  NotSoEasyHubspot::Contact.get_contact(123)
# or
  NotSoEasyHubspot::Contact.get_contact('test@gmail.com')

# Get all contacts 
# returns: parsed hubspot contacts
  NotSoEasyHubspot::Contact.get_contacts

# Delete a contact 
# required: contact_id 
# - contact_id: can be a hubspot contact_id or email
# returns: {status: 'success'}
  NotSoEasyHubspot::Contact.delete_contact(123)
# or 
  NotSoEasyHubspot::Contact.delete_contact('test@gmail.com')

# Update or Create a contact
# required: email, body 
# returns: parsed hubspot contact
  NotSoEasyHubspot::Contact.update_or_create_contact(properties: { email: '', firstname: '', lastname: '' , etc: ''})


# Parse hubspot contact example
{:id=>"701",
 :properties=>
  {:createdate=>"2023-02-08T20:10:36.858Z", 
  :email=>"amber_becker@quigley.io", 
  :firstname=>"Amber", 
  :hs_content_membership_status=>"inactive", 
  :hs_is_contact=>"true", 
  :hs_is_unworked=>"true", 
  :hs_object_id=>"701", 
  :hs_pipeline=>"contacts-lifecycle-pipeline", 
  :lastmodifieddate=>"2023-02-14T18:24:07.654Z", 
  :lastname=>"Quigley", 
  :lifecyclestage=>"lead"},
 :createdAt=>"2023-02-08T20:10:36.858Z",
 :updatedAt=>"2023-02-14T18:24:07.654Z",
 :archived=>false}
```

### Deals
```ruby
# Create a deal 
  # required: body
  # returns: parsed hubspot deal
  NotSoEasyHubspot::Deal.create_deal(properties: { dealname: '', amount: '', etc: ''})

# Update a deal
# required: deal_id, body
# - deal_id: must be a hubspot deal_id
# returns: parsed hubspot deal
  NotSoEasyHubspot::Deal.update_deal(123, properties: { dealname: '', amount: '', etc: ''})

# Get a deal
# required: deal_id
# - deal_id: must be a hubspot deal_id
# returns: parsed hubspot deal
  NotSoEasyHubspot::Deal.get_deal(123)

# Get all deals
# returns: parsed hubspot deals
  NotSoEasyHubspot::Deal.get_deals

# Delete a deal
# required: deal_id
# - deal_id: must be a hubspot deal_id
# returns: {status: 'success'}
  NotSoEasyHubspot::Deal.delete_deal(123)
```

## Error Handling

```ruby
def call
  begin
    NotSoEasyHubspot::Contact.create_contact(body)
  rescue NotSoEasyHubspot::HubspotApiError => e
    # handle error code
    # e.message = 'Contact already exists. Existing ID: 801'
    Rails.logger.info(e.message)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/oroth8/not_so_easy_hubspot.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
