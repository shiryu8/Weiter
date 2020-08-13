class MessagesController < ApplicationController
	before_action :authenticate_user!, :only => [:create]

    def create
    	#全てのメッセージの情報が入った:messageと:room_idのキーがある場合
    	if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      		@message = Message.create(params.require(:message).permit(:user_id, :talk_message, :room_id).merge(:user_id => current_user.id))
      	#ない場合
    	else
      		flash[:alert] = "メッセージ送信に失敗しました。"
    	end
    	redirect_to "/rooms/#{@message.room_id}"
	end
end
