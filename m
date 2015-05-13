Return-Path: <rtc-linux+bncBDKZNNNLXAHBBB6FZ6VAKGQEHXFEVEY@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id xv6si2327273pab.2.2015.05.13.16.47.19
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 16:47:19 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NOB00A92BEQMUB0@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 14 May 2015 00:47:14 +0100 (BST)
Message-id: <5553E281.2090803@samsung.com>
Date: Thu, 14 May 2015 08:47:13 +0900
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
MIME-version: 1.0
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Olof Johansson <olof@lixom.net>,
 Doug Anderson <dianders@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 rtc-linux@googlegroups.com, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/2] rtc: Fix module autoload for max77xx RTC drivers
References: <1431530282-10672-1-git-send-email-javier.martinez@collabora.co.uk>
In-reply-to: <1431530282-10672-1-git-send-email-javier.martinez@collabora.co.uk>
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

On 14.05.2015 00:18, Javier Martinez Canillas wrote:
> Hello Alexandre and Alessandro,
> 
> This is a trivial series that fixes module autoloading for the Maxim
> MAX77686 and MAX77802 RTC drivers that didn't export their platform
> device ID table with MODULE_DEVICE_TABLE() so modalias information
> was not available.
> 
> The series is composed of the following patches:
> 
> Javier Martinez Canillas (2):
>   rtc: max77686: Report platform modalias to fix module autoload
>   rtc: max77802: Report platform modalias to fix module autoload
> 
>  drivers/rtc/rtc-max77686.c | 1 +
>  drivers/rtc/rtc-max77802.c | 1 +
>  2 files changed, 2 insertions(+)

For the patchset:
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
