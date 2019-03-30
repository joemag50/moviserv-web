class ApiController < ApplicationController
  def login
    return unless auth_user!

    @user.new_session
    render json: { result: true, object: @user }
  end

  def logout
    return unless auth_user!

    @user.end_session
    render json: { result: true }
  end

  def ram
    render json: { result: true, object: [{ server_name: "placeholder 0", avalible: "8GB", used: "3.45GB" },
                                          { server_name: "placeholder 1", avalible: "4GB", used: "2.10GB" }] }
  end

  def disk
    render json: { result: true, object: [{ server_name: "placeholder 0", avalible: "800GB", used: "35GB" },
                                          { server_name: "placeholder 1", avalible: "400GB", used: "20GB" }] }
  end

  def tasks
    render json: {
      result: true,
      object: {
        tasks: [
          { name: "task0", pid: "01", uptime: "1:00:00" },
          { name: "task1", pid: "02", uptime: "2:00:00" },
          { name: "task2", pid: "03", uptime: "3:00:00" },
          { name: "task3", pid: "04", uptime: "4:00:00" },
          { name: "task4", pid: "05", uptime: "5:00:00" }
        ]
      }
    }
  end

  def reboot
    render json: { result: true, object: { message: 'Favor de esperar' } }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def auth_user!
    @user = User.find_by( email: user_params[:email] )
    unless @user
      render json: { result: false, error: "Email or Password are incorrect", error_es: 'El usuario o la contraseña son incorrectos' }
      return nil
    end
    unless @user.valid_password?(user_params[:password])
      render json: { result: false, error: "Email or Password are incorrect", error_es: 'El usuario o la contraseña son incorrectos' }
      return nil
    end
    true
  end
end
