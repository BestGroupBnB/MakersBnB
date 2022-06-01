class SpaceEntity

  def initialize(name, description, price, date_from, date_to,  user_id, id = nil)
    @name = name
    @description = description
    @price = price
    @date_from = date_from
    @date_to = date_to
    @user_id = user_id
    @id = id
  end

  def name
    return @name
  end

  def description
    return @description
  end

  def price
    return @price
  end

  def date_from
    return @date_from
  end

  def date_to
    return @date_to
  end

  def user_id
    return @user_id
  end

  def id
    return @id
  end

end