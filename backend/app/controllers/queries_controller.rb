class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :update, :destroy]

  def new
    @query = Query.new
  end

  # GET /queries
  def index
    @queries = current_user.queries.all
  end

  # GET /queries/1
  def show
    @query = Query.find(params[:id])

    render html: @query
  end

  # POST /queries
  def create
    build_query_from_octokit

    respond_to do |format|
      if @query.save
        format.html { render 'queries/show' }
      else
        format.html { render html: @query.errors }
      end
    end
  end

  # PATCH/PUT /queries/1
  def update
    if @query.update(query_params)
      render json: @query
    else
      render json: @query.errors, status: :unprocessable_entity
    end
  end

  # DELETE /queries/1
  def destroy
    @query.destroy
  end

  private

  def build_query
    @query = current_user.queries.new(
      name: params[:name],
      profile_url: @user_found[:html_url],
      repositories: @repositories,
      avatar: @user_found[:avatar_url]
    )
  end

  def request_to_octokit
    response = Octokit::Client.new.repositories(params[:name]).to_a
    @user_found = Octokit::Client.new.user(params[:name]).to_h
    @repositories = response.map do |repo|
      repo.to_h.slice(:id, :name, :html_url, :description)
    end
  end

  def build_query_from_octokit
    request_to_octokit
    build_query
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_query
    @query = Query.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def query_params
    params.fetch(:query, {})
  end
end
