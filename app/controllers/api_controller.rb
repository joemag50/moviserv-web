class ApiController < ApplicationController
  def create_account
    @user = User.new user_params
    if @user.save
      @user.new_session
      render json: { result: true, object: @user }
    else
      render json: { result: false, object: @user.errors }
    end
  end

  def create_server
    return unless auth_user!

    @server = Server.new create_server_params
    @server.user_id = @user.id
    if @server.save
      render json: { result: true, object: @server }
    else
      render json: { result: false, object: @server.errors }
    end
  end

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

  def databases_index
    return unless auth_user!

    @servers = Server.where(user_id: @user.id)
    @objects = []
    @servers.map do |server|
      server.db_servers.map do |db_server|
        @objects << db_server
      end
    end
    render json: { result: true, object: @objects }
  end

  def db_stats
    @object = DbServer.find(db_params[:server_id])
    render json: { result: true, object: @object.db_analitics }
  end

  def db_remove_user
    @object = DbUser.find(params[:id])
    @object.destroy
    render json: { result: true, object: @object }
  end

  private

  def create_server_params
    params.require(:server).permit(:name, :address)
  end

  def db_params
    params.require(:db).permit(:server_id)
  end

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
