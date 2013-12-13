require 'builder'

module RailsAdmin
  module Config
    module Fields
      module Types
        class State < RailsAdmin::Config::Fields::Base
          # Register field type for the type loader
          RailsAdmin::Config::Fields::Types::register(self)
          include RailsAdmin::Engine.routes.url_helpers

          register_instance_option :pretty_value do
            @state_machine_options = ::RailsAdminState::Configuration.new @abstract_model

            state = bindings[:object].send(name)
            state_class = @state_machine_options.state(state)
            s = bindings[:object].class.state_machines[name.to_sym].states[state.to_sym]
            ret = [
              '<div class="label ' + state_class + '">' + s.human_name + '</div>',
              '<div style="height: 10px;"></div>'
            ]

            events = bindings[:object].class.state_machines[name.to_sym].events
            bindings[:object].send("#{name}_events".to_sym).each do |event|
              next if @state_machine_options.disabled?(event)
              event_class = @state_machine_options.event(event)
              ret << bindings[:view].link_to(
                events[event].human_name,
                state_path(model_name: @abstract_model, id: bindings[:object].id, event: event, attr: name),
                method: :post, 
                class: "btn btn-mini #{event_class}",
                style: 'margin-bottom: 5px;'
              )
            end
            ('<div style="white-space: normal;">' + ret.join(' ') + '</div>').html_safe
          end

          register_instance_option :formatted_value do
            pretty_value
          end

          register_instance_option :partial do
            :form_state
          end

          register_instance_option :multiple? do
            false
          end
        end
      end
    end
  end
end
