# frozen_string_literal: true

module Api
  module V1
    class AssignmentsController < ApplicationController
      def index
        @assignments = Assignment.all
        render json: { status: 'SUCCESS',\
                       message: 'Loaded assignments',\
                       data: @assignments }, status: :ok
      end

      def show
        @assignment = Assignment.find(params[:id])
        @work_order = @assignment.work_order.title
        @worker = @assignment.worker.name
        render json: { status: 'SUCCESS',\
                       message: 'Loaded assignment',\
                       data: [@assignment, @work_order, @worker] }, status: :ok
      end

      def new
        @assignment = Assignment.new
      end

      def create
        @assignment = Assignment.create(assignment_params)
        if @assignment.save
          render json: { status: 'SUCCESS',\
                         message: 'Assignment saved',\
                         data: @assignment }, status: :ok
        else
          render json: { status: 'ERROR',\
                         message: 'Assignment not saved',\
                         data: @assignment.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @assignment = Assignment.find(params[:id])
        @assignment.destroy
        render json: { status: 'SUCCESS',\
                       message: 'Assignment deleted',\
                       data: @assignment }, status: :ok
      end

      def update
        @assignment = Assignment.find(params[:id])
        if @assignment.update(assignment_params)
          render json: { status: 'SUCCESS',\
                         message: 'Assignment updated',\
                         data: @assignment }, status: :ok
        else
          render json: { status: 'ERROR',\
                         message: 'Assignment not updated',\
                         data: @assignment.errors }, status: :unprocessable_entity
        end
      end

      private

      def assignment_params
        params.permit(:work_order_id, :worker_id)
      end
    end
  end
end
