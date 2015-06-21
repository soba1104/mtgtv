Mtgtv::App.controllers :expansion do
  get :index, :with => :name do
    name = params[:name].upcase
    path = Padrino.root(Config[:data], "#{name}.json")
    # TODO json の存在チェックとエラー処理
    # TODO 相対パスを入れられても大丈夫なようにエスケープ、ないし候補のエキスパンションと照合する。
    json = File.read(path)
    @expansion = Expansion.from_json(File.read(path))
    puts @expansion.cards.inspect
    render 'expansion/index'
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
