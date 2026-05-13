class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:followed_id])
    Current.user.followings << user
    redirect_back fallback_location: root_path
  end

  def destroy
    relationship = Relationship.find(params[:id])
    user = relationship.followed
    Current.user.active_relationships.find_by(followed_id: user.id).destroy
    redirect_back fallback_location: root_path
  end
end
