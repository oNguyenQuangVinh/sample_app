module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".ruby_sample"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def render_404
    respond_to do |format|
      format.html{render file: "#{Rails.root}/public/404", layout: false, status: :not_found}
      format.xml{head :not_found}
      format.any{head :not_found}
    end
  end
end
