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

          register_instance_option :enum_method do
            @enum_method ||= (bindings[:object].class.respond_to?("#{name}_enum") || bindings[:object].respond_to?("#{name}_enum")) ? "#{name}_enum" : name
          end

          register_instance_option :pretty_value do
            @state_machine_options = ::RailsAdminStateMachine::Configuration.new @abstract_model

            state = bindings[:object].send(name)
            state_class = @state_machine_options.state(state)
            ret = [
              '<div class="label ' + state_class + '">' + I18n.t("state_machine.states.#{@abstract_model.model_name.underscore}.#{state}", default: state.to_s) + '</div>',
              '<div style="height: 10px;"></div>'
            ]

            bindings[:object].send("#{name}_events".to_sym).each do |event|
              event_class = @state_machine_options.event(event)
              ret << bindings[:view].link_to(
                I18n.t("state_machine.events.#{@abstract_model.model_name.underscore}.#{event}", default: event.to_s),
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
        end
      end
    end
  end
end
