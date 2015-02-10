#    t.string   "street"
#    t.string   "postalcode"
#    t.string   "town"
#    t.string   "email"
#    t.string   "telephone"
#    t.datetime "created_at"
#    t.datetime "updated_at"

FactoryGirl.define do
  factory :contact do
    street "examplestr. 5"
    postalcode "33739"
    town "Bielefeld"
    telephone "051092999"    
  end
end