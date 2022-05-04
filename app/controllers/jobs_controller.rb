class JobsController < ApplicationController
    before_action :set_job, only: [:show, :update, :destroy]
    
    def index
        @jobs = Job.all

        if @jobs.length > 0
            render(
                json: {jobs: @jobs},
                states: 200
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
            json: {job: @job},
            status: 200
        )
    end

    def create
        @company = Company.find_by(id: params[:company_id])

        if @company.nil? 
            render(
            json: {message: "No existe la compañía con el id #{params[:id]}"},
            status: 404
            )
        else
            @job = @company.jobs.build(job_params)

            if @job.save
                render(
                    json: {job: @job},
                    status: 201
                )
            else
                render_errors_response
            end
        end
    end

    def update
        if @job.update(job_params)
            render(
                json: {job: @job},
                status: 200
            )
        else
            render_errors_response
        end
    end

    def destroy
        if @job.destroy
            render(
                json: {mensaje: "El aviso de trabajo especificado ha sido eliminado"},
                status: 200
            )
        else
            render_errors_response
        end
    end

    def change_state
        @applicant_job = ApplicantJob.find_by(job_id: params[:id], applicant_id: params[:applicant_id])
        if @applicant_job.nil?
            render(
                json: {mensaje: "La aplicación de trabajo a la cual desea cambiarle el estado no existe"},
                status: 404
            )
        else
            if @applicant_job.update(status: params[:status]) 
                render(
                    json: {mensaje: "La aplicación de trabajo ha cambiado su estado exitosamente"},
                    status: 200
                )
            else
                render_errors_response
            end
        end
    end


    private
    def job_params
        params.require(:job).permit(:name, :description)
    end
=begin
    def applicant_job_params
        params.require(:applicant_job).permit(:status)
    end
=end
    def set_job
        @job = Job.find_by(id: params[:id])
        if @job.nil?
            render(
                json: {message: "El aviso de trabajo #{params[:id]} no existe"},
                status: 404
            )
            false
        end
    end

    def render_errors_response
        render(
            json: {message: @job.errors.details},
            status: 400
        )
    end
end
