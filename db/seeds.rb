# def initialize_master_table(model)
#   (model.respond_to?(:delete_all!)) ? model.delete_all! : model.destroy_all
#   model.connection.execute("alter table #{model.table_name} AUTO_INCREMENT = 1;")
# end
# module ActiveRecord
#   class Base
#     def self.create_once(args)
#       unless self.exists?(args[:id])
#         record    = self.new(args, :without_protection => true)
#         record.id = args[:id]
#         record.save!
#       end
#     end
#   end
# end
# 
# initialize_master_table(User)
User.create({email: "yochiyochi@example.jp", password: "yochiyochi"})
