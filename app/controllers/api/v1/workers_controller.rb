# frozen_string_literal: true

module Api
  module V1
    class WorkersController < ApplicationController
      def index
        @workers = Worker.all
        json_response(@workers)
      end

      def show
        @worker = Worker.find(params[:id])
        @work_orders = @worker.work_orders.order('deadline ASC')
        json_response([@worker, @work_orders])
      end

      def new
        @worker = Worker.new
      end

      def create
        @worker = Worker.create(worker_params)
        if @worker.save
          json_response(@worker, :created)
        else
          json_response(@worker, :unprocessable_entity)
        end
      end

      def destroy
        @worker = Worker.find(params[:id])
        @worker.destroy
        head :no_content
      end

      def update
        @worker = Worker.find(params[:id])
        @worker.update(worker_params)
        head :no_content
      end

      private

      def worker_params
        params.permit(:name, :company_name, :email)
      end
    end
  end
end
