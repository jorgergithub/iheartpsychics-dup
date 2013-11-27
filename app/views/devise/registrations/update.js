$("#password_modal form").replaceWith("<%= escape_javascript(render 'clients/modals/password_form', user: @user ) %>");

<% if @user.errors.blank? %>
closeModal();
<% end %>