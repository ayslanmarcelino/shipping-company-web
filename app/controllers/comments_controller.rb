# frozen_string_literal: true

class CommentsController < UsersController
  before_action :set_truckload

  def create
    return if cannot?(:create, Comment) && unauthorized_redirect

    @comment = Comment.new(params_comment)

    if @comment.save
      redirect_to(truckload_path(@truckload))
      flash[:success] = 'Atualização de monitoramento concluída com sucesso.'
    else
      redirect_to(truckloads_path)
      flash[:danger] = 'Erro ao atualizar monitoramento.'
    end
  end

  private

  def unauthorized_redirect
    redirect_to(root_path)
    flash[:danger] = 'Você não possui permissão para realizar esta ação.'
  end

  def params_comment
    params.require(:comment)
          .permit(:description, :attachment)
          .with_defaults(user: current_user,
                         enterprise: current_user.enterprise,
                         truckload: @truckload)
  end

  def set_truckload
    @truckload = Truckload.find(params.require(:comment)[:id])
  end
end
