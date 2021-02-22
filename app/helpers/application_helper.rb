module ApplicationHelper
    def user_avatar(user)
        if user.avatar.attached? then
            user.avatar
        else
            "/default_avatar.jpg"
        end
    end
end
