class LanguagesController < ApplicationController

  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all
  end

  # GET /languages/1
  # GET /languages/1.json
  def show
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def language_params
      params.require(:language).permit(:lg_name, :lg_code)
    end
end
