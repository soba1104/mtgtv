Mtgtv::App.controllers :expansion do
  loader = proc do |name|
    # TODO json の存在チェックとエラー処理
    # TODO 相対パスを入れられても大丈夫なようにエスケープ、ないし候補のエキスパンションと照合する。
    name = name.upcase
    path = Padrino.root(Config[:data], "#{name}.json")
    File.read(path)
  end

  get :index, :with => :name do
    json = loader.call(params[:name])
    @expansion = Expansion.from_json(json)
    render 'expansion/index'
  end

  get :json, :map => '/expansion/:name/json', :provides => :json do
    loader.call(params[:name])
  end

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
