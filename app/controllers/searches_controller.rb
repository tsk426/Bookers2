class SearchesController < ApplicationController
    before_action :authenticate_user!
  
    def search
      @model = params[:model] # "user" or "book"
      @method = params[:method]
      @content = params[:content]
  
      if @model == "user"
        @records = User.search_for(@content, @method)
      elsif @model == "book"
        @records = Book.search_for(@content, @method)
      else
        @records = []
      end
    end
  end
  
    private
  
    def search_for(model, content, method)
      case model
      when "user"
        case method
        when "perfect"
          User.where(name: content)
        when "forward"
          User.where("name LIKE ?", "#{content}%")
        when "backward"
          User.where("name LIKE ?", "%#{content}")
        else
          User.where("name LIKE ?", "%#{content}%")
        end
      when "book"
        case method
        when "perfect"
          Book.where("title = ? OR body = ?", content, content)
        when "forward"
          Book.where("title LIKE ? OR body LIKE ?", "#{content}%", "#{content}%")
        when "backward"
          Book.where("title LIKE ? OR body LIKE ?", "%#{content}", "%#{content}")
        else
          Book.where("title LIKE ? OR body LIKE ?", "%#{content}%", "%#{content}%")
        end
      end
    end

