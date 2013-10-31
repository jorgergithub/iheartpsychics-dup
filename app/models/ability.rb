class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :home
    can :create, "devise/sessions"
    can :callback, :paypal
    can [:create], "calls/psychic_callbacks"

    if user
      authorize_user(user)
    else
      authorize_guests
    end
  end

  private

  def authorize_user(user)
    can :destroy, "devise/sessions"

    if user.role
      self.send("authorize_#{user.role}")
    end
  end

  def admin_roles
    %w(
      admin/customer_service_representatives
      admin/manager_directors
      admin/website_admins
      admin/accountants
      admin/schedule_jobs
    )
  end

  def admin_and_website_admin_roles
    %w(
      admin/dashboards
      admin/psychics
      admin/clients
      admin/calls
      admin/packages
    )
  end

  def website_admin_roles
    %w(
      admin/orders
      admin/surveys
      admin/categories
      admin/horoscopes
      admin/newsletters
      admin/subscribers
    )
  end

  def csr_roles
    %w(
      customer_service_representatives
      admin/clients
      admin/calls
      admin/orders
    )
  end

  def authorize_accountant
    can :access, %w(admin/invoices admin/payments)
  end

  def authorize_admin
    can :access, admin_and_website_admin_roles + admin_roles
  end

  def authorize_website_admin
    can :access, admin_and_website_admin_roles + website_admin_roles
  end

  def authorize_client
    can [:update, :edit, :show, :reset_pin, :make_favorite, :remove_favorite], :clients
    can [:show, :new, :create, :paypal], :orders
    can [:search, :about], :psychics
    can [:callback, :success, :cancel], :paypal
    can [:new, :create], :callbacks
    can :access, :client_phones
    can :access, :surveys
  end

  def authorize_csr
    can :access, csr_roles
  end

  def authorize_guests
    can [:new, :create, :confirmation], :psychic_applications
    can :create, :registrations
  end

  def authorize_manager_director
    can :access, %w(admin/psychic_applications admin/psychics)
  end

  def authorize_psychic
    can :access, [:psychics, :schedules, :invoices]
  end
end
