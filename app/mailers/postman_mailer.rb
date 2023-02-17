class PostmanMailer < ApplicationMailer
    def alert_newuser(data)
        @em=data.email
        mail(to: @em,subject: "New account created")
    end
    def alert_forpass(data1,data2)
        @d1=data1.email
        @d2=data2
        mail(to: @d1,subject: "New password generated")
    end
    def alert_resetpass(data)
        @d3=data.email
        mail(to: @d3,subject: "password reseted")
    end
end
