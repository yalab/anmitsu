class <%= controller_class_name %>Controller < ApplicationController
  respond_to :html, :json
  def index
    respond_with(@<%= plural_table_name %> = <%= orm_class.all(class_name) %>)
  end

  def show
    respond_with(@<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>)
  end

  def new
    respond_with(@<%= singular_table_name %> = <%= orm_class.build(class_name) %>)
  end

  def edit
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
    @<%= orm_instance.save %>
    respond_with(@<%= singular_table_name %>)
  end

  def update
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
    respond_with(@<%= singular_table_name %>)
  end

  def destroy
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    (status, msg) = (@<%= orm_instance.destroy %>) ?
      [:ok, {:notice => t('Destroy success')}] : [:unprocessable_entity, {:alert => t('Destroy failure')}]
    respond_with(@<%= singular_table_name %>) do |format|
      format.html { redirect_to(<%= index_helper %>_url, msg) }
      format.json  { head status }
    end
  end
end
