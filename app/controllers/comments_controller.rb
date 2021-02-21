class CommentsController < ApplicationController

    def create
        new_author_id = current_user.id
        new_body = params["comment"]["body"]
        new_post_id = params["format"]
        Comment.create(body: new_body, author_id: new_author_id, post_id: new_post_id)
        Post.find_by(id: new_post_id).increment!(:comments_count,  1) if !new_body.empty?
        redirect_back fallback_location: @post
    end

    def destroy
        Comment.find_by(id: params[:id]).destroy
        Post.find_by(id: params[:post_id]).decrement!(:comments_count,  1)
        respond_to do |format|
          format.html { redirect_back fallback_location: @post, notice: "Comment was successfully destroyed." }
          format.json { head :no_content }
        end
    end
end
