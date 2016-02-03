Return-Path: <rtc-linux+bncBAABBAPCYW2QKGQEHDXV6EY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id tn7si616255pac.1.2016.02.02.19.16.16
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Feb 2016 19:16:16 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 3/4] rtc: max77686: avoid reference of parent
 device info multiple palces
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com
References: <1454419012-18050-1-git-send-email-ldewangan@nvidia.com>
 <1454419012-18050-4-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56B170F8.3040901@osg.samsung.com>
Date: Wed, 3 Feb 2016 00:16:08 -0300
MIME-Version: 1.0
In-Reply-To: <1454419012-18050-4-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Laxman,

On 02/02/2016 10:16 AM, Laxman Dewangan wrote:
> Get rid of referring parent device info for register access
> all the places by making regmap as part of max77686 rtc
> device info. This will also remove the need of storing parent
> device info in max77686 rtc device info as this is no more required.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
--
Javier Martinez Canillas
Open Source Group
Samsung Research America

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
