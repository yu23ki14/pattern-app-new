class ShufflesController < ApplicationController
  def index
    if params[:pattern] != nil
      if params[:pattern] == "lp" || params[:pattern] == "pdp" || params[:pattern] == "cp" || params[:pattern] == "pp"
        language = Language.find_by(lg_code: params[:pattern])
        @patterns = Pattern.where(language_id: language.id).shuffle
      else
        redirect_to shuffles_path
      end
    end
  end
end
