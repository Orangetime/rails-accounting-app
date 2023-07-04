module Actor
  TYPES = {
    'admin' => Admin,
    'employee' => Employee
  }.freeze

  def employee?
    instance_of? TYPES['employee']
  end

  def admin?
    instance_of? TYPES['admin']
  end
end