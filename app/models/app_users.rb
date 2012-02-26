class AppUsers < ActiveRecord::Base

  def generate_code(app_id)
    code = Array.new(6){rand 10}.join
    if !AppUsers.find_by_app_id_and_code(app_id, code)
      return code
    else
      generate_code(app_id)
    end
  end
  
  def generate_primary_id()
    prim_id = Array.new(15){rand 10}.join
    if !AppUsers.find_by_id(prim_id)
      return prim_id
    else
      generate_primary_id()
    end
  end
  
end
