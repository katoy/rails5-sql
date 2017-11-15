class Sub::TypesController < ApplicationController
  include Sub::TypesDoc
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /sub/types/some_operation
  def some_operation
  end
end
