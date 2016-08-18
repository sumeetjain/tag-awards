def as_json(options={})
  super(:only => [:title,:theater_id],
        :include => {
          :theater => {:only => [:name]},
          
        }
  )
end