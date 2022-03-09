class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :update, :destroy]
  def new
    @query = Query.new

    respond_to do |format|
      format.html
    end
  end

  # GET /queries
  def index
    @queries = Query.all

    render json: @queries
  end

  # GET /queries/1
  def show
    render json: @query
  end

  # POST /queries
  def create
    response = Octokit::Client.new.repositories(params[:name]).to_a
    user_found = Octokit::Client.new.user(params[:name]).to_h
    repositories = response.map do |repo|
      repo.to_h.slice(:id, :name, :html_url, :description)
    end

    @query = current_user.queries.new(
      name: query_params[:name],
      profile_url: user_found[:html_url],
      repositories: repositories,
      avatar: user_found[:avatar_url]
    )

    # render html: ...
    respond_to do |format|
      format.html do
        if @query.save
          render html: @query
        else
          render html: @query.errors
        end
      end
      forrmat.json do
        if @query.save
          render json: @query, status: :created, location: @query
        else
          render json: @query.errors, status: :unprocessable_entity
        end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def query_params
      params.fetch(:query, {})
    end
end
