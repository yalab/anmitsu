Mail::Field.module_eval do
  def new_field_with_subject_charset(name, value, charset)
    field = new_field_without_subject_charset(name, value, charset)
    if field.is_a?(Mail::SubjectField) && charset
      field.charset = charset
    end
    field
  end
  alias_method_chain :new_field, :subject_charset
end
