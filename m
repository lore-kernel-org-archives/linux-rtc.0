Return-Path: <rtc-linux+bncBDKZNNNLXAHBBMNQW2WQKGQEPO5P44Q@googlegroups.com>
Received: from mail-qk0-x232.google.com (mail-qk0-x232.google.com. [2607:f8b0:400d:c09::232])
        by gmr-mx.google.com with ESMTPS id b76si2017204ywe.1.2015.07.20.17.54.09
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 17:54:09 -0700 (PDT)
Received: by mail-qk0-x232.google.com with SMTP id v3so123639146qkd.3
        for <rtc-linux@googlegroups.com>; Mon, 20 Jul 2015 17:54:09 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1437433372-15425-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
	<1437433372-15425-3-git-send-email-dmitry.torokhov@gmail.com>
Date: Tue, 21 Jul 2015 09:54:09 +0900
Message-ID: <CAJKOXPdt1fJTQuuyxDj5K3OK=S=3nAXtg4o9nXzY1ZCBYj0X1w@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH 3/4] RTC: properly manage lifetime of dev and
 cdev in rtc device
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-07-21 8:02 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> struct rtc embeds both struct dev and struct cdev.  Unfortunately character
> device structure may outlive the parent rtc structure unless we set it up
> as parent of character device so that it will stay pinned until character
> device is freed.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/rtc/rtc-dev.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
