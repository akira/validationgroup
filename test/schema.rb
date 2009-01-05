ActiveRecord::Schema.define(:version => 0) do
  create_table :validation_group_models, :force => true do |t|
    t.column :name,        :string, :limit => 255
    t.column :description,    :string, :limit => 255
    t.column :address,    :string, :limit => 255    
    t.column :email,    :string, :limit => 255    
  end
end