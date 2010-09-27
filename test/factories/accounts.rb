Factory.define :account do |f|
  f.content "Design"
  f.price 1
  f.estimation{ Factory(:estimation) }
end
