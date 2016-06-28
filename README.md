# Fuggle

TODO: Write a gem description

## Installation

    $ gem install fuggle

## Fugglefile

Create a `Fugglefile` in the root of your project.

### Tasks

Tasks are defined in `task` blocks:

```ruby
task :deploy do
  # Do deployment stuff here
end
```

### Methods

Methods are convenient ways to run commands and copy files.

```ruby
  local("command to run locally")
```

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/rbwsam/fuggle/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
