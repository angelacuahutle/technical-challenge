class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :update, :destroy]

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
    response = Octokit::Client.new.repositories(query_params[:name]).to_h
    user_found = response&.user.to_json
    repositories = response.repositories.to_json

    @query = current_user.queries.new(
      name = query_params[:name],
      profile_url = user_found.profile_url,
      repositories = repositories,
      avatar = user_found.avatar
    )

    if @query.save
      # render html: ...
      render json: @query, status: :created, location: @query
    else
      render json: @query.errors, status: :unprocessable_entity
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
