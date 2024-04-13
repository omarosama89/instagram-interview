class Api::ServicesController < Api::ApiApplicationControllerController

  def index
    @services = Service.where(active: true).sort {|a, b| Service.service_families[a.service_family] <=> Service.service_families[b.service_family]}
  end
end
