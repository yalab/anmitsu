Factory.define :estimation do |f|
  f.title "An Development"
  f.description "Create your CMS"
  f.note "note"
  f.client_name "yalab"
  f.after_build{|e| Factory(:account, :estimation => e) }
end
