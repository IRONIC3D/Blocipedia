class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 5)
    @wiki = Wiki.new
    @publish_status = { Draft: 1, Publish: 2, Scheduled: 3 }
    @users = User.all
    @wiki.collaborators.build # The more I do the more collaborators

    # authorize @wikis
    authorize @wiki, :new?
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new

    authorize @wiki
  end

  def create
    puts "***#{params.to_yaml}"
    @wiki = current_user.original_wikis.build(wiki_params)

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved"
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again"
      render :new
    end
  end

  def edit
    puts "***#{params.to_yaml}"
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki_edit = Wiki.find(params[:id])

    authorize @wiki_edit

    if @wiki_edit.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated succefully"
      redirect_to @wiki_edit
    else
      flash[:error] = "There was an error saving the wiki. Please try again"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    
    authorize @wiki
    if @wiki.destroy
       flash[:notice] = "\"#{title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash[:error] = "There was an error deleting the topic."
       render :show
     end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :publish, :draft, :scheduled, :publish_type, collaborators_attributes: [:id, :user_id])
  end
end
