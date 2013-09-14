require 'builder'

module RailsAdmin
  module Config
    module Fields
      module Types
        class StateMachine < RailsAdmin::Config::Fields::Base
          # Register field type for the type loader
          RailsAdmin::Config::Fields::Types::register(self)
          include RailsAdmin::Engine.routes.url_helpers

          register_instance_option :partial do
            :form_enumeration
          end

          register_instance_option :enum do
            enum = {}
            bindings[:object].class.state_machines[name.to_sym].states.each do |state|
              enum[state.name.to_s] = state.human_name
            end
            enum
          end

          register_instance_option :pretty_value do
            @state_machine_options = ::RailsAdminStateMachine::Configuration.new @abstract_model

            state = bindings[:object].send(name)
            state_class = @state_machine_options.state(state)
            s = bindings[:object].class.state_machines[name.to_sym].states[state.to_sym]
            ret = [
              '<div class="label ' + state_class + '">' + s.human_name + '</div>',
              '<div style="height: 10px;"></div>'
            ]

            events = bindings[:object].class.state_machines[name.to_sym].events
            bindings[:object].send("#{name}_events".to_sym).each do |event|
              event_class = @state_machine_options.event(event)
              ret << bindings[:view].link_to(
                events[event].human_name,
                state_machine_path(model_name: @abstract_model, id: bindings[:object].id, event: event, attr: name),
                method: :post, 
                class: "btn btn-mini #{event_class}",
                style: 'margin-bottom: 5px;'
              )
            end
            ('<div style="white-space: normal;">' + ret.join(' ') + '</div>').html_safe
          end

          register_instance_option :export_value do
            value.inspect
          end

          register_instance_option :multiple? do
            false
          end
        end
      end
    end
  end
end
