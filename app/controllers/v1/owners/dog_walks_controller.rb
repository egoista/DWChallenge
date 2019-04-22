# frozen_string_literal: true

module V1
  module Owners
    class DogWalksController < ApplicationController
      include Paginatable

      before_action :set_dog_walk, only: %i[show start finish]

      # GET /owners/dog_walks
      def index
        @dog_walks = params[:all] ? DogWalk.all : DogWalk.future_walks
        paginated_walks = @dog_walks.page(params.fetch(:page) { 1 }).per 10

        render json: { 
          data: ActiveModelSerializers::SerializableResource.new(paginated_walks), 
          pagination: pagination_meta(paginated_walks)
        }
      end

      # POST /owners/dog_walks
      def create
        @dog_walk = DogWalk.new(dog_walk_params)
        @dog_walk.price = price_service.calculate

        if @dog_walk.save
          render json: @dog_walk, status: :created
        else
          render json: @dog_walk.errors, status: :unprocessable_entity
        end
      end

      # GET /owners/dog_walks/{id}
      def show
        render json: @dog_walk
      end

      # PUT /owners/dog_walks/{dog_walk_id}/start
      def start
        @dog_walk.start_walk

        render head: :ok
      end

      # PUT /owners/dog_walk/{id}/finish
      def finish
        @dog_walk.finish_walk

        render head: :ok
      end

      private

      def price_service
        PriceService.new(@dog_walk)
      end
      def set_dog_walk
        @dog_walk = DogWalk.find(params[:id])
      end

      def dog_walk_params
        params
          .require(:dog_walk)
          .permit(
            :scheduled_date,
            :scheduled_start_time,
            :scheduled_end_time,
            :duration,
            starting_position_attributes: %i[latitude longitude],
            ending_position_attributes: %i[latitude longitude]
          )
          .merge(
            owner: current_owner,
            walker: current_walker,
            status: 'accepted'
          )
      end
    end
  end
end
