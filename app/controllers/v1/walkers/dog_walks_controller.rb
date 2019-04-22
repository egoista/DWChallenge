# frozen_string_literal: true

module V1
  module Walkers
    class DogWalksController < ApplicationController
      before_action :set_dog_walk, only: [:update_position]

      def update_position
        @dog_walk.update_position(*update_position_params)
      end

      private

      def update_position_params
        params.require(%i[latitude longitude])
      end

      def set_dog_walk
        @dog_walk = DogWalk.find(params[:id])
      end
    end
  end
end
