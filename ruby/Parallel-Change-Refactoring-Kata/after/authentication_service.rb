# frozen_string_literal: true

class AuthenticationService
  #
  # the goal is to replace the following method with:
  # def authenticated?(role, user_id)
  #

  def authenticated?(user_id)
    user_id == 12_345
  end
end

class AuthenticationClient
  def initialize(authentication_service)
    @authentication_service = authentication_service
  end

  def run
    authenticated = @authentication_service.authenticated?(33)
    puts "authenticated: #{authenticated}"
  end
end

class YetAnotherClient
  def run
    AuthenticationService.new.authenticated?(100)
  end
end

if $PROGRAM_NAME == __FILE__
  client = AuthenticationClient.new(AuthenticationService.new)
  client.run
end
