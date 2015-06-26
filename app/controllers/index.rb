Mtgtv::App.controllers do
  get :index do
    path = Padrino.root(Config[:data], 'expansions.json')
    json = File.read(path)
    @expansions = JSON.parse(json)
    render 'index/index'
  end
end
