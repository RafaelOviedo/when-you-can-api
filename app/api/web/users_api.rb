# frozen_string_literal: true

module Web
  class UsersAPI < Grape::API
    helpers ::Helpers::Error
    
    resources :users do
      desc 'Returns a list of Users' do
        success [{ model: Entities::User, code: 200 }]
      end
      params do
        optional :first_name, type: String
        optional :last_name, type: String
        optional :email, type: String
        optional :admin, type: Boolean
      end
      get do
        users = User.all
        users = users.with_first_name(params[:first_name]) if params[:first_name].present?
        users = users.with_last_name(params[:last_name]) if params[:last_name].present?
        users = users.with_email(params[:email]) if params[:email].present?
        users = users.with_admin(params[:admin]) if params[:admin].in?([true, false])
        present users, with: Entities::User
      end

      desc 'Creates an User' do
        success [{ model: Entities::User, code: 201 }]
      end
      params do
        requires :group_id, type: Integer
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
      post do
        user = User.new(declared(params))

        if user.save
          present user, with: Entities::User
        else
          model_error!(user)
        end
      end

      route_param :id do
        desc 'Returns a single User' do
          success [{ model: Entities::User, code: 200 }]
        end
        get do
          user = User.find(params[:id])
          present user, with: Entities::User
        end

        desc 'Updates an User' do
          success [{ model: Entities::User, code: 200 }]
        end
        params do
          optional :first_name, type: String
          optional :last_name, type: String
          optional :email, type: String
          optional :password, type: String
          optional :password_confirmation, type: String
          optional :admin, type: Boolean
        end
        patch do
          user = User.find(params[:id])
          update_params = declared(params, include_missing: false)

          if user.update(update_params)
            present user, with: Entities::User
            byebug
          else
            error!({ error: user.errors.full_messages }, 422)
          end
        end

        desc 'Deletes a User' do
          success [{ model: Entities::User, code: 200 }]
        end
        params do
        end
        delete do
          user = User.find(params[:id])
          user.delete
          present user, with: Entities::User
        end
      end
    end
  end
end
