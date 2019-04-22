# frozen_string_literal: true

module V1
  module Owners
    class PetsController < ApplicationController

      # GET /owners/pets
      def index
        render json: Pet.where(owner: current_owner)
      end
    end
  end
end
