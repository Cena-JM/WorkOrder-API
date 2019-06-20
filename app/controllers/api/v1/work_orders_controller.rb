# frozen_string_literal: true

module Api
  module V1
    class WorkOrdersController < ApplicationController
      def index
        @work_orders = WorkOrder.all
        render json: { status: 'SUCCESS',\
                       message: 'Loaded work_orders',\
                       data: @work_orders }, status: :ok
      end

      def show
        @work_order = WorkOrder.find(params[:id])
        render json: { status: 'SUCCESS',\
                       message: 'Loaded work_order',\
                       data: @work_order }, status: :ok
      end

      def new
        @work_order = WorkOrder.new
      end

      def create
        @work_order = WorkOrder.create(work_order_params)
        if @work_order.save
          render json: { status: 'SUCCESS',\
                         message: 'Work order saved',\
                         data: @work_order }, status: :ok
        else
          render json: { status: 'ERROR',\
                         message: 'Work order not saved',\
                         data: @work_order.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @work_order = WorkOrder.find(params[:id])
        @work_order.destroy
        render json: { status: 'SUCCESS',\
                       message: 'Work order deleted',\
                       data: @work_order }, status: :ok
      end

      def update
        @work_order = WorkOrder.find(params[:id])
        if @work_order.update(work_order_params)
          render json: { status: 'SUCCESS',\
                         message: 'Work order updated',\
                         data: @work_order }, status: :ok
        else
          render json: { status: 'ERROR',\
                         message: 'Work order not updated',\
                         data: @work_order.errors }, status: :unprocessable_entity
        end
      end

      private

      def work_order_params
        params.permit(:title, :description, :deadline)
      end
    end
  end
end
