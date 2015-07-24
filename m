Return-Path: <rtc-linux+bncBDKZNNNLXAHBBXXUY2WQKGQEQWRZNIQ@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id x3si1243301pdh.2.2015.07.23.21.09.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 21:09:02 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NRZ00JGN4UX5T30@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 24 Jul 2015 05:08:57 +0100 (BST)
Message-id: <55B1BA5A.7020401@samsung.com>
Date: Fri, 24 Jul 2015 13:08:58 +0900
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
MIME-version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 2/3] RTC: switch wakealarm attribute to DEVICE_ATTR_RW
References: <1437692468-24788-1-git-send-email-dmitry.torokhov@gmail.com>
 <1437692468-24788-2-git-send-email-dmitry.torokhov@gmail.com>
In-reply-to: <1437692468-24788-2-git-send-email-dmitry.torokhov@gmail.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 24.07.2015 08:01, Dmitry Torokhov wrote:
> Instead of using older style DEVICE_ATTR for wakealarm attribute let's
> switch to using DEVICE_ATTR_RW that ensures consistent across the kernel
> permissions on the attribute.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/rtc/rtc-sysfs.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

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
