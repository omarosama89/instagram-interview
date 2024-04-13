# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

    def new_subscription_email
        UserMailer.new_subscription_email(Subscription.first)
    end
end
