module Admin::PermissionsHelper

  def permissions
    return { 'view' => 'View' , 'create tickets' => 'Create tickets' , 'edit tickets' => 'Edit tickets' ,
      'delete tickets' => 'Delete tickets'}
  end
end
