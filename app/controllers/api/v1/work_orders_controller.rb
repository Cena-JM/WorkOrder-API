# frozen_string_literal: true

module Api
  module V1
    class WorkOrdersController < ApplicationController
      def index
        @work_orders = WorkOrder.all
        json_response(@work_orders)
      end

      def show
        @work_order = WorkOrder.find(params[:id])
        json_response(@work_order)
      end

      def new
        @work_order = WorkOrder.new
      end

      def create
        @work_order = WorkOrder.create(work_order_params)
        if @work_order.save
          json_response(@work_order, :created)
        else
          json_response(@work_order, :unprocessable_entity)
        end
      end

      def destroy
        @work_order = WorkOrder.find(params[:id])
        @work_order.destroy
        head :no_content
      end

      def update
        @work_order = WorkOrder.find(params[:id])
        @work_order.update(work_order_params)
        head :no_content
      end

      private

      def work_order_params
        params.permit(:title, :description, :deadline)
      end
    end
  end
end
