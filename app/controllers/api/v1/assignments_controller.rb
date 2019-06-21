# frozen_string_literal: true

module Api
  module V1
    class AssignmentsController < ApplicationController
      def index
        @assignments = Assignment.all
        json_response(@assignments)
      end

      def show
        @assignment = Assignment.find(params[:id])
        @work_order = @assignment.work_order.title
        @worker = @assignment.worker.name
        json_response([@assignment.id, @work_order, @worker])
      end

      def new
        @assignment = Assignment.new
      end

      def create
        @assignment = Assignment.create(assignment_params)
        if @assignment.save
          json_response(@assignment, :created)
        else
          json_response(@assignment, :unprocessable_entity)
        end
      end

      def destroy
        @assignment = Assignment.find(params[:id])
        @assignment.destroy
        head :no_content
      end

      def update
        @assignment = Assignment.find(params[:id])
        @assignment.update(assignment_params)
        head :no_content
      end

      private

      def assignment_params
        params.permit(:work_order_id, :worker_id)
      end
    end
  end
end
