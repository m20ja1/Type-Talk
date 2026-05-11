module AdminAuthentication
  extend ActiveSupport::Concern

  included do
    helper_method :authenticated_admin?
  end

  private

    def authenticated_admin?
      resume_admin_session
    end

    def authenticate_admin!
      unless resume_admin_session
        redirect_to new_admin_session_path, alert: "管理者としてログインしてください"
      end
    end

    def resume_admin_session
      # クッキー「admin_session_id」があれば、それを使ってログイン状態を復元
      if session = Session.find_by(id: cookies.signed[:admin_session_id])
        Current.session = session
      else
        false
      end
    end

    def start_new_admin_session_for(admin)
        session = admin.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip)
        Current.session = session
        cookies.signed.permanent[:admin_session_id] = { value: session.id, httponly: true, same_site: :lax }
    end

    def terminate_admin_session
        Current.session&.destroy
        cookies.delete(:admin_session_id)
    end
end