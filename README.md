# RailsAdminStateMachine

Allows easily sending state_machine events to a model from Rails Admin

## Installing

Add this line to your application's Gemfile:

    gem 'rails_admin_state_machine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_admin_state_machine

## Usage


Add the set_state action:

    RailsAdmin.config do |config|
      config.actions do
        ......
        state_machine
      end
    end

Make the field you need display as state_machine:

    rails_admin do
      list do
        field :state, :state_machine
        ...
      end
      edit do
        field :state, :state_machine
        ...
      end
      ...
    end

States and event names button classes and I18N:

    rails_admin do
      list do
        field :state, :state_machine
        ...
      end
      ...
      state_machine({
        events: {reject: 'btn-warning'}
        states: {on_moderation: 'btn-warning'}
      })
    end
  
i18n:

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
