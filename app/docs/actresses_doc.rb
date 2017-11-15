module ActressesDoc
 # we need the DSL, right?
 extend Apipie::DSL::Concern

 api :GET, '/actresses', 'List actresses'
 def index
  # Nothing here, it's just a stub
 end

 api :GET, '/actresses/:id', 'Show actress'
 def show
  # Nothing here, it's just a stub
 end

 api :POST, '/actresses', 'Create actress'
 def create
  # Nothing here, it's just a stub
 end
end
