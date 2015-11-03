class VisitorsController < ApplicationController
before_action :set_values_map
require 'open-uri'

  def tos
  end

  def privacy
  end

  def about
  end

  def index
    
  	@projects = Project.order(:name)
    if params[:tag]
      unless params[:tag][:distrito].blank? || params[:tag][:seccion].blank?
        get_electoral_information(params)
      else
        load_markers
      end
    else
      load_markers
    end

    

  end


  private
  def set_values_map
    @projetc =  Project.new
    @array_lat=[]
    @array_lng=[]
    @array_name=[]
    
  end

  def get_electoral_information(params)
    @projects.each_with_index do |project, index|
      response = open("https://cicadmin.cartodb.com:443/api/v2/sql?q=select municipio, distrito, seccion from public.nl_secciones_electorales where ST_Within(ST_GeomFromText('POINT(#{project.lat} #{project.lng})', 4326), the_geom)").read
      parsed = JSON.parse(response)
      if parsed["total_rows"].to_i > 0
        if parsed["distrito"] == params[:tag][:distrito] || params[:tag][:seccion] == parsed["seccion"]
          @array_lat[index] = project.lat
          @array_lng[index] = project.lng
          @array_name[index] = project.name
        end
      end
    end

  end

  def load_markers
    @projects.each_with_index do |project, index|
        @array_lat[index] = project.lat
        @array_lng[index] = project.lng
        @array_name[index] = project.name
      end
    
  end
end
