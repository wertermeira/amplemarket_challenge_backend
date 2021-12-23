class TemplatesController < ApplicationController
  before_action :set_template, only: %i[show update destroy]

  def index
    @templates = Template.all
    render json: @templates, serializer_each: TemplateSerializer, status: :ok
  end

  def show
    render json: @template, serializer: TemplateSerializer, status: :ok
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      render json: @template, serializer: TemplateSerializer, status: :created
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  def update
    if @template.update(template_params)
      render json: @template, serializer: TemplateSerializer, status: :accepted
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @template.destroy
    head :no_content
  end

  private

  def set_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:name, :content)
  end
end
