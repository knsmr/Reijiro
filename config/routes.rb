Reijiro::Application.routes.draw do
  resources :words, only: [:index, :show]
  resources :clips
  match '/picknew' => 'clips#picknew', as: 'picknew'
  match '/nextup' => 'clips#nextup', as: 'nextup'
  match '/next' => 'clips#next', as: 'next'
  root to: 'clips#index'
end
