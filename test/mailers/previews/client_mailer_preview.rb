# Preview all emails at http://localhost:3000/rails/mailers/client_mailer
class ClientMailerPreview < ActionMailer::Preview

    def order_receipt_email
        ClientMailer.order_receipt_email(OrderRow.last)
    end

    def package_receipt_email
        ClientMailer.package_receipt_email(Subscription.first)
    end

    def package_started_email
        ClientMailer.package_started_email(Subscription.first)
    end

    def package_ended_email
        ClientMailer.package_ended_email(Subscription.first)
    end

    def package_failed_email
        ClientMailer.package_failed_email(Subscription.first)
    end
end
