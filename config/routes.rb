TagManager::Application.routes.draw {

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  resources :solr_mappings #, only: [:create, :destroy]
  resources :tags

  #resources :tags do |solr_mappings|
  #  resources :solr_mappings
  #end

  root to: "tags#index"

  get 'solr_mappings/edit_from_tag/:id' => 'solr_mappings#edit_from_tag'
  get 'solr_mappings/new_from_tag/:id' => 'solr_mappings#new_from_tag'
  get "services/autocomplete"
  get "services/getTagsSolrMappings"

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

}
