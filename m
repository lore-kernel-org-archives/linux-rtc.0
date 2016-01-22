Return-Path: <rtc-linux+bncBD2OLRXW4ABBBAP4Q62QKGQEHIJ5ZPQ@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id tn7si659084pac.1.2016.01.22.02.01.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 02:01:37 -0800 (PST)
Message-ID: <56A1FB7B.5060903@nvidia.com>
Date: Fri, 22 Jan 2016 15:20:51 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	<linux-kernel@vger.kernel.org>
CC: Kukjin Kim <kgene@kernel.org>, <rtc-linux@googlegroups.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, <linux-samsung-soc@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2 04/10] rtc: max77686: Use a driver data
 struct instead hard-coded values
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com> <1453407813-14646-5-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453407813-14646-5-git-send-email-javier@osg.samsung.com>
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


On Friday 22 January 2016 01:53 AM, Javier Martinez Canillas wrote:
> The driver has some hard-coded values such as the minimum delay needed
> before a RTC update or the mask used for the sec/min/hour/etc registers.
>
> Use a data structure that contains these values and pass as driver data
> using the platform device ID table for each device.
>
> This allows to make the driver's ops callbacks more generic so other RTC
> that are similar but don't have the same values can also be supported.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

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
