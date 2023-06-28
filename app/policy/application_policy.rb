class ApplicationPolicy
  class ActionForbiddenErorr < StandardError; end

  def Initialize(current_user, resource)
    @current_user = current_user
    @resource = resource
  end

  def result(action)
    raise ActionForbiddenErorr unless send("#{action}?")
  end

  class << self
    def authorize!(current_user, resource, action)
      new(current_user, resource).result(action)
    end
  end
end
