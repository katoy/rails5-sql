module MoviesDoc
 # we need the DSL, right?
 extend Apipie::DSL::Concern

 api :GET, '/movies', 'List movies'
 def index
  # Nothing here, it's just a stub
 end

 api :GET, '/moviess/:id', 'Show movie'
 def show
  # Nothing here, it's just a stub
 end

 api :POST, '/moviess', 'Create movie'
 def create
  # Nothing here, it's just a stub
 end
end
