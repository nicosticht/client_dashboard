class API::V1::Companies < Grape::API
  resource :companies do
    # TODO create api
    #index
    desc 'Return list of companies along with employees, contractors, clients'
    get do
      companies = Company.all
      present companies, with: API::Entities::V1::Company
    end

    #show
    desc 'Get company details'
    params do
      requires :id, type: Integer, desc: 'Id of Company'
    end
    get ':id' do
      company = Company.find params[:id]
      error!(:not_found, 404) unless company
      company = API::Entities::V1::Company.represent(company, only: [:id, :identity, :name])
      company.as_json
    end

    #edit
    desc 'Edit Company'
    params do
      requires :id, type: Integer, desc: 'Id of Company'
    end
    get ':id/edit' do
      company = Company.find params[:id]
      error!(:not_found, 404) unless company
      company = API::Entities::V1::Company.represent(company, only: [:id, :name])
      company.as_json
    end


    #update
    desc 'Update Company'
    params do
      requires :id, type: Integer, desc: 'Id of Company'
      requires :name, type: String, desc: 'Name of company'
    end
    put ':id' do
      company = Company.find params[:id]
      company.update! params
      company = API::Entities::V1::Company.represent(company, only: [:id, :identity, :name])
      company.as_json
    end

    #destroy
    desc 'Delete Company'
    params do
      requires :id, type: Integer, desc: 'Id of Company'
    end
    delete ':id' do
      company = Company.find params[:id]
      error!(:not_found, 404) unless company
      company.destroy
      present success: true, message: "Deleted company #{params[:id]} successfully!"
    end
  end
end
