# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    namespace :owners do
      resources :dog_walks, only: %i[index show create] do
        member do
          put :start
          put :finish
        end
      end

      resources :pets, only: [:index]
    end

    namespace :walkers do
      resources :dog_walks, only: [] do
        member do
          put :update_position
        end
      end
    end
  end
end
