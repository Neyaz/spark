module SparkTestTask
  module Admin
    module ProductsControllerDecorator
      def batch_upload
        if params['products_file'].present?
          path = ProductsFileUploadOp.submit!(io: params['products_file']).path
          result = ProductsImportOp.submit!(path: path).result
        end
        if !result.nil?
          flash[:success] = Spree.t('notice_messages.success_import')
        else
          flash[:error] = Spree.t('notice_messages.failed_import')
        end
        respond_with do |format|
          format.html { redirect_to collection_url }
          format.js   { render layout: false }
        end
      end
    end
  end
end

Spree::Admin::ProductsController.prepend SparkTestTask::Admin::ProductsControllerDecorator
