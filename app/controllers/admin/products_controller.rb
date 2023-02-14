module Admin
  class ProductsController < HomeController
    # include ProductSearchable

    before_action :set_product, only: %i[show edit create update destroy]

    def index
      # query = params['query'] || ''
      # res = Product.search(query)
      # render json: res.response['hits']['hits']

      @all_products = Product.all.order(:id)
    end

    def new
      # @product = Product.new
    end

    def show; end

    def edit; end

    # def create
    #   @product.create(product_params)
    # end
    #
    # def update
    #   if @product.update(product_params)
    #     redirect_to admin_product_path(@product)
    #   else
    #     render :edit, status: :unprocessable_entity
    #   end
    # end
    #
    # def destroy; end

    def search
      @products = Product.search(params[:query]) if params[:query].present?
    end

    def filter
      @products = Product.filter(params[:price_min], params[:price_max], params[:sort_by])
      render 'admin/products/search'
    end

    private

    def product_params
      params.require(:product).permit(:title, :description, images: [])
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
