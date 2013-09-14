# RailsAdminState

Allows easily sending state_machine events to a model from Rails Admin

## Screenshot

 ![Rails Admin State Machine](https://rscx.ru/state.png)


## Installing

Add this line to your application's Gemfile:

    gem 'rails_admin_state'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_admin_state

## Usage

Add the set_state action:

    RailsAdmin.config do |config|
      config.actions do
        ......
        state
      end
    end

Make the field you need display as state_machine:

    rails_admin do
      list do
        field :state, :state
        ...
      end
      edit do
        field :state, :state
        ...
      end
      ...
    end

### States and event names button classes:

    rails_admin do
      list do
        field :state, :state
        ...
      end
      ...
      state({
        events: {reject: 'btn-warning'}
        states: {on_moderation: 'btn-warning'}
      })
    end
  
### i18n:

Just as usual for state_machine, see:

http://rdoc.info/github/pluginaweek/state_machine/master/StateMachine/Integrations/Mongoid
http://rdoc.info/github/pluginaweek/state_machine/master/StateMachine/Integrations/ActiveRecord

For namespaced models use "/", just as usual: "Blog::Post" is "blog/post"


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
