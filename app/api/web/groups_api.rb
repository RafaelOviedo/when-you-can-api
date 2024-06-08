# frozen_string_literal: true

module Web
  class GroupsAPI < Grape::API
    helpers ::Helpers::Error
    
    resources :groups do
      desc 'Returns a list of Groups' do
        success [{ model: Entities::Group, code: 200 }]
      end
      params do
        optional :name, type: String
      end
      get do
        groups = Group.all
        groups = groups.with_name(params[:name]) if params[:name].present?
        present groups, with: Entities::Group
      end

      desc 'Creates a Group' do
        success [{ model: Entities::Group, code: 201 }]
      end
      params do
        requires :name, type: String
      end
      post do
        group = Group.new(declared(params))

        if group.save
          present group, with: Entities::Group
        else
          model_error!(group)
        end
      end

      route_param :id do
        desc 'Returns a single Group' do
          success [{ model: Entities::Group, code: 200 }]
        end
        get do
          group = Group.find(params[:id])
          present group, with: Entities::Group
        end

        desc 'Updates an Group' do
          success [{ model: Entities::Group, code: 200 }]
        end
        params do
          optional :name, type: String
          optional :start_date, type: Date
          optional :end_date, type: Date
          optional :matching_date, type: Date
        end
        patch do
          group = Group.find(params[:id])
          update_params = declared(params, include_missing: false)

          if group.update(update_params)
            present group, with: Entities::Group
            byebug
          else
            error!({ error: group.errors.full_messages }, 422)
          end
        end

        desc 'Deletes a Group' do
          success [{ model: Entities::Group, code: 200 }]
        end
        params do
        end
        delete do
          group = Group.find(params[:id])
          group.delete
          present group, with: Entities::Group
        end
      end
    end
  end
end
