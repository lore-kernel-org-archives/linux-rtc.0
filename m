Return-Path: <rtc-linux+bncBDKZNNNLXAHBB5PJ7WVQKGQE5JZNXYA@googlegroups.com>
Received: from mail-yk0-x236.google.com (mail-yk0-x236.google.com. [2607:f8b0:4002:c07::236])
        by gmr-mx.google.com with ESMTPS id d142si197682ywe.7.2015.06.15.17.59.33
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2015 17:59:33 -0700 (PDT)
Received: by ykfr66 with SMTP id r66so1807941ykf.0
        for <rtc-linux@googlegroups.com>; Mon, 15 Jun 2015 17:59:33 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <13a98422-3d30-4ff0-a4b9-ecf67ed0a757@googlegroups.com>
References: <13a98422-3d30-4ff0-a4b9-ecf67ed0a757@googlegroups.com>
Date: Tue, 16 Jun 2015 09:59:33 +0900
Message-ID: <CAJKOXPd2uPW9ivdj_FF8jCYOEkmj2OgGMxKUqo8QOpei0FgTVQ@mail.gmail.com>
Subject: Re: [rtc-linux] [QUESTION] rtc and regmap_irq wakeup
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-06-16 3:26 GMT+09:00 Alexey Mednyy <swexru@gmail.com>:
>
> Hello all!
>
> I'm trying to add wakealarm support to rtc-mc13xxx driver. But I've faced some troubles.
>
> It's using nested IRQs over mc13xxx-core driver.
> What I've done:
> 1. Added device_init_wakeup to both mc13xxx-core (parent irq) and to rtc-mc13xxx
> 2. Added dev_pm_ops to both core and rtc
> 3. Added enable_irq_wake to core suspend for core irq

Consider adding it also in RTC driver.

>
> 4. Disabled 1HZ irq in rtc-mc13xxx ( do not wakeup after 1 second)
>
> Now I've got wakealarm file and I can write to it. But device doesn't wakeup.

Does the wakealarm work fine without suspend? You can easily test it
with rtcwake.

(...)

Best regards,
Krzysztof

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
