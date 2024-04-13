class UserMailer < ApplicationMailer

    def new_subscription_email(subscription)
        @subscription = subscription
        user = User.first
        mail(to: user.email, subject: 'New Subscription')
    end

    def test_email(email)
        mail(to: email, subjec: 'test test')
    end
end
