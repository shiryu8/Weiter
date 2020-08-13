class RoomsController < ApplicationController

  before_action :authenticate_user!

  def create
  	@room = Room.create
    #Entriesテーブルに作成された@roomにひもづくidと、現在ログインしているユーザーのidを保存
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    #fields_for @entryで保存したparamsの情報(:user_id, :room_id)を許可し、@roomにひもづくidを保存
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def index
    @user = current_user
    @currentEntries = current_user.entries
    myRoomIds = []

    @currentEntries.each do | entry |
      myRoomIds << entry.room.id
    end
    #@anotherEntriesにはuser_idが自分のidではない相手の情報が配列として入っている
    @anotherEntry = Entry.where(room_id: myRoomIds).where('user_id != ?', @user.id)
    #@anotherUseridsには@anotherEntryからuser_idだけを選ぶ(distinctメソッドとは重複レコードを1つにまとめる)
    @anotherUserids = @anotherEntry.select('user_id').distinct
    #@anotherUseridsを数字列に
    @anotherUserids = @anotherUserids.map { |h| h[:user_id] }
  end

  def show
  	@room = Room.find(params[:id])
    #現在ログインしているユーザーのidとそれにひもづいたルームのidがある場合
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
    	#Messageテーブルにルームのidと紐づいたメッセージを表示
      	@messages = @room.messages
      	@message = Message.new
      	@entries = @room.entries
    	#ない場合
    else
      	redirect_back(fallback_location: user_path)
    end
  end
end
