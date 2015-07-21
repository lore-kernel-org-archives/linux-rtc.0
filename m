Return-Path: <rtc-linux+bncBDKZNNNLXAHBBHFGW2WQKGQEUX3ECAI@googlegroups.com>
Received: from mail-qg0-x236.google.com (mail-qg0-x236.google.com. [2607:f8b0:400d:c04::236])
        by gmr-mx.google.com with ESMTPS id j14si2010219ywa.5.2015.07.20.17.32.28
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 17:32:28 -0700 (PDT)
Received: by mail-qg0-x236.google.com with SMTP id d69so51566511qge.0
        for <rtc-linux@googlegroups.com>; Mon, 20 Jul 2015 17:32:28 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
Date: Tue, 21 Jul 2015 09:32:28 +0900
Message-ID: <CAJKOXPcXszaRxVnm2H9XAB-diLfitCadfsL0u2UNwXg_ZBT2HA@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH 1/4] RTC: fix double free in
 rtc_register_device() error path
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org,
	Vasiliy Kulikov <segooon@gmail.com>
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
> Commit 59cca865f21e9e7beab73fcf79ba4eb776a4c228 correctly noted that naked
> kfree() should not be used after failed device_register() call, however,
> while it added the needed put_device() it forgot to remove the original
> kfree() causing double-free.
>
> Cc: Vasiliy Kulikov <segooon@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/rtc/class.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

I think it can be cc'ed stable (with fixes tag).

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
