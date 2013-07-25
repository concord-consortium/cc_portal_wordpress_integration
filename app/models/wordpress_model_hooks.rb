module WordpressModelHooks
  Portal::Clazz.class_eval do
    before_create :create_class_blog

    def create_class_blog
      if self.teacher
        begin
          wp = Wordpress.new
          wp.create_class_blog(self.class_word, self.teacher.user, self.name)
        rescue
        end
      end
    end
  end

  Portal::StudentClazz.class_eval do
    # also link/unlink the student to/from the class's wordpress blog
    after_create :add_to_blog
    before_destroy :remove_from_blog

    def add_to_blog
      begin
        wp = Wordpress.new
        wp.add_user_to_clazz(self.student, self.clazz, "author")
      rescue
      end
    end

    def remove_from_blog
      begin
        wp = Wordpress.new
        wp.remove_user_from_clazz(self.student, self.clazz)
      rescue
      end
    end
  end

  Portal::TeacherClazz.class_eval do
    # also link/unlink the teacher to/from the class's wordpress blog
    after_create :add_to_blog
    before_destroy :remove_from_blog

    def add_to_blog
      # If we're adding a teacher, but the class only has one teacher,
      # that means the class was just created, so don't bother adding
      # the teacher to the blog since they'll already be associated.
      return if self.clazz.teachers.size == 1
      begin
        wp = Wordpress.new
        wp.add_user_to_clazz(self.teacher, self.clazz, "administrator")
      rescue
      end
    end

    def remove_from_blog
      begin
        wp = Wordpress.new
        wp.remove_user_from_clazz(self.teacher, self.clazz)
      rescue
      end
    end
  end

  User.class_eval do
    before_create  :create_blog_user
    before_update  :update_blog_user
    before_destroy :destroy_blog_user

    def create_blog_user
      begin
        wp = Wordpress.new
        wp.create_user(self)
      rescue
      end
    end

    def update_blog_user
      begin
        wp = Wordpress.new
        wp.update_user(self)
      rescue
      end
    end

    def destroy_blog_user
      begin
        wp = Wordpress.new
        wp.destroy_user(self)
      rescue
      end
    end
  end
end