resources :issues, only: [] do
  member do
    get :download_zipped_attachments
  end
end
