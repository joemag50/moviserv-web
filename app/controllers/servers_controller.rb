class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: [:show, :edit, :update, :destroy]

  def index
    @servers = Server.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @server = Server.new
  end

  def edit
  end

  def create
    @server = Server.new(server_params)

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render :show, status: :created, location: @server }
      else
        format.html { render :new }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { render :show, status: :ok, location: @server }
      else
        format.html { render :edit }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @server.destroy
    respond_to do |format|
      format.html { redirect_to servers_url, notice: 'Server was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_server
      @server = Server.find(params[:id])
    end

    def server_params
      params.require(:server).permit(:name, :address, :user_id)
    end
end
