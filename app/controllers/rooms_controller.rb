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
