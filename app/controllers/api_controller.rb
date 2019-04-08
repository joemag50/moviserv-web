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

  def servers
    render json: { result: true, object: Server.where(user_id: server_params[:user_id]) }
  end

  def ram
    return unless auth_user!

    @object = Server.where(user_id: server_params[:user_id]).map do |server|
      server.ram
    end
    render json: { result: true, object: @object }
  end

  def disk
    return unless auth_user!

    @object = Server.where(user_id: server_params[:user_id]).map do |server|
      server.disk
      server.disk
    end
    render json: { result: true, object: @object }
  end

  def tasks
    return unless auth_user!

    @object = Server.where(user_id: server_params[:user_id]).map do |server|
      server.tasks
    end
    render json: { result: true, object: @object }
  end

  def stop_task
    return unless auth_user!

    @object = Server.find(task_params[:server_id])
    @object.stop_task(task_params[:pid])
    @object.update_tasks
    render json: { result: true, object: @object.server_tasks }
  end

  def start_task
    return unless auth_user!

    @object = Server.find(task_params[:server_id])
    @object.start_task(task_params[:pid])
    @object.update_tasks
    render json: { result: true, object: @object.server_tasks }
  end

  def reboot
    Server.find(reboot_params[:server_id]).reboot
    render json: { result: true, object: { message: 'En 1 minuto se reiniciara el servidor' } }
  end

  private

  def reboot_params
    params.require(:reboot).permit(:server_id)
  end

  def server_params
    params.require(:server).permit(:user_id)
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def task_params
    params.require(:task).permit(:server_id, :pid, :action)
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
