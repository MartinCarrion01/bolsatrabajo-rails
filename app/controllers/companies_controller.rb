class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy]

  def index
    @companies = Company.all

    if @companies.length > 0
      render(
        json: {companies: @companies},
        status: 200
      )
    else
      render(
        json: {message: "No se han cargado compañías hasta el momento"},
        status: 200
      )
    end
  end

  def show
    render(
      json: {company: @company},
      status: 200
    )
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      render(
        json: {company: @company},
        status: 201
      )
    else
      render_errors_response
    end
  end

  def update
    if @company.update(company_params)
      render(
        json: {company: @company},
        status: 200
      )
    else
      render_errors_response
    end
  end

  def destroy
    if @company.destroy
      render(
        json: {mensaje: "La compañia especificada ha sido eliminada"},
        status: 200
    )
    else
      render_errors_response
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :jobs)
  end

  def set_company 
    @company = Company.find_by(id: params[:id])
    if @company.nil? 
      render(
        json: {message: "No existe la compañía con el id #{params[:id]}"},
        status: 404
      )
      false
    end
  end

  def render_errors_response
    render(
      json: {mensaje: @company.errors.details},
      status: 400
    )
  end
end
