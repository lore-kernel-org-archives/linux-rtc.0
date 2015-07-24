Return-Path: <rtc-linux+bncBDKZNNNLXAHBBIPVY2WQKGQEX43HPSA@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id ct6si1309493pdb.1.2015.07.23.21.10.08
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 21:10:09 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NRZ000904WSDW30@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 24 Jul 2015 05:10:04 +0100 (BST)
Message-id: <55B1BA9F.7070305@samsung.com>
Date: Fri, 24 Jul 2015 13:10:07 +0900
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
MIME-version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 3/3] RTC: switch to using is_visible() to
 control sysfs attributes
References: <1437692468-24788-1-git-send-email-dmitry.torokhov@gmail.com>
 <1437692468-24788-3-git-send-email-dmitry.torokhov@gmail.com>
In-reply-to: <1437692468-24788-3-git-send-email-dmitry.torokhov@gmail.com>
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
> Instead of creating wakealarm attribute manually, after the device has been
> registered, let's rely on facilities provided by the attribute groups to
> control which attributes are visible and which are not. This allows to to
> create all needed attributes at once, at the same time that we register RTC
> class device.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/rtc/class.c     |  4 +---
>  drivers/rtc/rtc-core.h  | 19 +++-------------
>  drivers/rtc/rtc-sysfs.c | 59 +++++++++++++++++++++++++------------------------
>  3 files changed, 34 insertions(+), 48 deletions(-)

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
