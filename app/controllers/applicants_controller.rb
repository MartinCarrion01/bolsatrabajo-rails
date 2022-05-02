class ApplicantsController < ApplicationController
    before_action: :set_applicant, only: [:show, :update, :destroy]

    def index
        @applicants = Applicant.all

        if @applicants.length > 0
            render(
                json: {applicants: @applicants},
                status: 200
            )
        else
            render(
                json: {message: "No se han cargado aplicantes hasta el momento"},
                status: 200
            )
        end
    end

    def show
        render(
            json: {applicant: @applicant},
            status: 200
        )
    end

    def create
        @applicant = Applicant.new(applicant_params)

        if @applicant.save
            render(
                json: {applicant: @applicant},
                status: 201
            )
        else
            render_errors_response
        end
    end

    def update
        if @applicant.update(applicant_params)
            render(
                json: {applicant: @applicant},
                status: 200
            )
        else
            render_errors_response
        end
    end

    def destroy
        if @applicant.destroy
            render(
                json: {mensaje: "El aplicante especificado ha sido eliminado"},
                status: 200
            )
        else
            render_errors_response
        end
    end

    private
    def applicant_params
        params.require(:applicant).permit(:first_name, :last_name, :age)
    end

    def set_applicant
        @applicant = Applicant.find_by(id: params[:id])
        if @applicant.nil?
            render(
                json: {message: "El aplicante #{params[:id]} no existe"},
                status: 404
            )
            false
        end
    end

    def render_errors_response
        render(
            json: {message: @applicant.errors.details},
            status: 400
        )
    end
end
