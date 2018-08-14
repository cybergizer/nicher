module Users
  class SessionsController < Devise::SessionsController
    def after_sign_in_path_for(user)
      if user.sign_in_count == 1
        edit_user_path(user.id)
      else
        root_path
      end
    end
  end
end
