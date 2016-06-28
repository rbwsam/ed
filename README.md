# Fuggle

Simple task automation tool with zero dependencies.

## Installation

    $ gem install fuggle

## Fugglefile

Create a blank file named `Fugglefile` in the root of your project.

A `Fugglefile` is just a Ruby file
with a simple DSL so feel free to require Ruby files and do other Ruby things.

### Tasks

Tasks are defined in `task` blocks.

```ruby
task :deploy do
  # Do deployment stuff here
end
```

### Methods

Methods are convenient ways to run commands and copy files.

```ruby
task :example do
  log 'message to be written to STDOUT'
  local 'command to run on local host'
  remote 'command to run on remote hosts'
  sync 'local source path' 'destination path on remote hosts' '[optional] options for rsync like -r --dell'
  remote_template 'name of template' 'destination path on remote hosts' '[optional] use sudo? defaul=false'
end
```

### Templates

Templates are dynamic file definitions that you can use to create configuration files
on remote hosts.

```ruby
template :upstart do
  # Templates must return a string.
  # Templates can embed configuration variables.
  <<-EOF
    stop on shutdown
    respawn
    respawn limit 10 5
    setuid ubuntu
    setgid ubuntu

    script
        export ROOT_URL=#{@root_url}
        exec node /opt/app/current/main.js
    end script
  EOF
end
```

## Environments

Environments are sets of variables that can be used in Tasks and Templates.

### Fugglefile.env

Create another blank file in the root of your project and name it `Fugglefile.env`.
`Fugglefile.env` is also just a Ruby file so feel free to do more Ruby stuff in it.

This is a great place to define environment specific configuration - I recommend that
you exclude it from version control.

```ruby
environment :production do
  # Variables are defined as instance variables (prefixed with @).
  @some_var = 'some value'

  # The @hosts variable is required for remote operations like remote, sync, and
  # remote_template.
  @hosts = ['you@your_host', 'you@another_host']

  # @ssh_opts is an optional string that will be used as options for ssh and rsync
  # commands.
  @ssh_opts = '-i ~/.ssh/key.pem'
end
````

## Contributing

1. Fork it ( https://github.com/rbwsam/fuggle/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
