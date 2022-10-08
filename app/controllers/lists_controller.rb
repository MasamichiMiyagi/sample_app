class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    # 1.&2. データを受け取り新規登録するためのインスタンス作成
    list = List.new(list_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    list.save
    # 4. トップ画面へリダイレクト
    redirect_to list_path(list.id)
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id]) #←今回はレコードを1件だけ取得するので、インスタンス変数名は単数形の「@list」にする。
  end

  def edit
  end

  private #←一種の境界線、「ここから下はこのcontrollerの中でしか呼び出せません」という意味があるので、他アクション(create,index,show等)を巻き込まないように一番下に書く。
  #↓以下ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body)
  end
end
