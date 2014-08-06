class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 5)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    @publish_status = { Draft: 1, Publish: 2, Scheduled: 3 }
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)

    puts "******************************"
    puts params[:wiki][:publish_type]
    puts "-------------------------------"

    authorize @wiki

    if (params[:wiki][:publish_type] == 1)
      @wiki.draft = true
      params[:wiki][:draft] = true
    elsif (params[:wiki][:publish_type] == 2)
      @wiki.publish = true
      params[:wiki][:publish] = true
    elsif (params[:wiki][:publish_type] == 3)
      @wiki.scheduled = true
      params[:wiki][:scheduled] = true
    end
        
    puts "******************************"
    puts "#{@wiki}"
    puts "-------------------------------"

    if @wiki.save
      if (params[:wiki][:publish_type] == 1)
        @wiki.update_attributes(draft: true)
      elsif (params[:wiki][:publish_type] == 2)
        @wiki.update_attributes(publish: true)
      elsif (params[:wiki][:publish_type] == 3)
        @wiki.update_attributes(scheduled: true)
      end
      flash[:notice] = "Wiki was saved"

      puts "******************************"
      puts "#{@wiki.draft}"
      puts "-------------------------------"

      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated succefully"
      redirect_to @wiki
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
    params.require(:wiki).permit(:title, :body, :private, :publish, :draft, :scheduled, :publish_type)
  end
end
