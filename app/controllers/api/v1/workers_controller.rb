# frozen_string_literal: true

module Api
  module V1
    class WorkersController < ApplicationController
      def index
        @workers = Worker.all
        render json: { status: 'SUCCESS',\
                       message: 'Loaded workers',\
                       data: @workers }, status: :ok
      end

      def show
        @worker = Worker.find(params[:id])
        @work_orders = @worker.work_orders.order('deadline ASC')
        render json: { status: 'SUCCESS',\
                       message: 'Loaded worker',\
                       data: [@worker, @work_orders] }, status: :ok
      end

      def new
        @worker = Worker.new
      end

      def create
        @worker = Worker.create(worker_params)
        if @worker.save
          render json: { status: 'SUCCESS',\
                         message: 'Worker saved',\
                         data: @worker }, status: :ok
        else
          render json: { status: 'ERROR',\
                         message: 'Worker not saved',\
                         data: @worker.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @worker = Worker.find(params[:id])
        @worker.destroy
        render json: { status: 'SUCCESS',\
                       message: 'Worker deleted',\
                       data: @worker }, status: :ok
      end

      def update
        @worker = Worker.find(params[:id])
        if @worker.update(worker_params)
          render json: { status: 'SUCCESS',\
                         message: 'Worker updated',\
                         data: @worker }, status: :ok
        else
          render json: { status: 'ERROR',\
                         message: 'Worker not updated',\
                         data: @worker.errors }, status: :unprocessable_entity
        end
      end

      private

      def worker_params
        params.permit(:name, :company_name, :email)
      end
    end
  end
end
