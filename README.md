# check_please_rspec_matcher

RSpec matcher to check for differences between two JSON strings (or Ruby data
structures parsed from them).  Most of the heavy lifting is done by the
[check_please](https://github.com/RealGeeks/check_please) gem; this is merely
an RSpec wrapper that I didn't want to include in the main gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'check_please_rspec_matcher'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install check_please_rspec_matcher

## Usage

The following code will raise a RSpec::Expectations::ExpectationNotMetError:

```ruby
reference = '{ "foo": 42 }'
candidate = '{ "foo": 43 }'
expect( candidate ).to check_please( reference )
```

The failure message should look something like this:

```
Expected two JSON data structures to match, but found the following diffs:

TYPE     | PATH | REFERENCE | CANDIDATE
---------|------|-----------|----------
mismatch | /foo | 42        | 43
```

### Options

The `check_please` helper method currently accepts a single keyword argument:

```ruby
reference = '{ "foo": 42 }'
candidate = '{ "foo": 43 }'
expect( candidate ).to check_please( reference, format_diffs: :json )
```

Using `:json` as above will output the diffs in JSON instead of a table:

```
Expected two JSON data structures to match, but found the following diffs:

[
  { "type": "mismatch", "path": "/foo", "reference": 42, "candidate": 43 }
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/check_please_rspec_matcher. This project is
intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [code of
conduct](https://github.com/[USERNAME]/check_please_rspec_matcher/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CheckPleaseRspecMatcher project's codebases, issue
trackers, chat rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/[USERNAME]/check_please_rspec_matcher/blob/master/CODE_OF_CONDUCT.md).
