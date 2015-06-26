Mtgtv::App.controllers :expansion do
  get :index, :with => :name do
    # TODO expansion の名前が正しいかどうかのチェック
    @name = params[:name].upcase
    render 'expansion/index'
  end

  get :json, :map => '/expansion/:name/json', :provides => :json do
    # TODO json の存在チェックとエラー処理
    # TODO 相対パスを入れられても大丈夫なようにエスケープ、ないし候補のエキスパンションと照合する。
    name = params[:name].upcase
    path = Padrino.root(Config[:data], "#{name}.json")
    File.read(path)
  end
end
