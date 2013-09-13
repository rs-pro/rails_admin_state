module RailsAdminStateMachine
  class Configuration
    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def options
      @options ||= {
          states: {
            published: 'label-success',
            sent: 'label-success',
            done: 'label-success',
            cancelled: 'label-danger',
            deleted: 'label-danger',
            trashed: 'label-danger',
            draft: 'label-info',
          },
          events: {
            publish: 'btn-success',
            confirm: 'btn-success',
            send: 'btn-success',
            done: 'btn-success',
            cancel: 'btn-danger',
            delete: 'btn-danger',
            trash: 'btn-danger',
          },
      }.merge(config)
    end

    def state(name)
      return '' if name.nil?
      options[:states][name.to_sym] || ''
    end

    def event(name)
      return '' if name.nil?
      options[:events][name.to_sym] || ''
    end

    protected
    def config
      if ::RailsAdmin::Config.model(@abstract_model.model).respond_to? :state_machine
        ::RailsAdmin::Config.model(@abstract_model.model).state_machine
      else
        {}
      end
    end
  end
end
