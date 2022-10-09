class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    # 1.&2. データを受け取り新規登録するためのインスタンス作成
    @list = List.new(list_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @list.save
      flash[:notice] = "投稿が成功しました"
      # 4. トップ画面へリダイレクト
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id]) #←今回はレコードを1件だけ取得するので、インスタンス変数名は単数形の「@list」にする。
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id])  # データ（レコード）を1件取得
    list.destroy  # データ（レコード）を削除
    redirect_to '/lists'  # 投稿一覧画面へリダイレクト
  end

  private #←一種の境界線、「ここから下はこのcontrollerの中でしか呼び出せません」という意味があるので、他アクション(create,index,show等)を巻き込まないように一番下に書く。
  #↓以下ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
