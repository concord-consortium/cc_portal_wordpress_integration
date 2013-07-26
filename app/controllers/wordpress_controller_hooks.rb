module WordpressControllerHooks
  Admin::ProjectsController.class_eval do
    before_filter :blog_show_fields, :only => [:index, :show, :update]
    before_filter :blog_edit_fields, :only => [:new, :edit]

    def blog_show_fields
      @additional_partials ||= []
      @additional_partials.push "wordpress/admin_project_show"
    end

    def blog_edit_fields
      @additional_partials ||= []
      @additional_partials.push "wordpress/admin_project_form"
    end
  end
end