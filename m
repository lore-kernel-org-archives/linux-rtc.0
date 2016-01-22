Return-Path: <rtc-linux+bncBD2OLRXW4ABBBV74Q62QKGQEX5HNF7A@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id ui7si601509pab.0.2016.01.22.02.03.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 02:03:02 -0800 (PST)
Message-ID: <56A1FBD0.20606@nvidia.com>
Date: Fri, 22 Jan 2016 15:22:16 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	<linux-kernel@vger.kernel.org>
CC: Kukjin Kim <kgene@kernel.org>, <rtc-linux@googlegroups.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, <linux-samsung-soc@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2 05/10] rtc: max77686: Add an indirection
 level to access RTC registers
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com> <1453407813-14646-6-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453407813-14646-6-git-send-email-javier@osg.samsung.com>
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
> The max77686 driver is generic enough that can be used for other
> Maxim RTC IP blocks but these might not have the same registers
> layout so instead of accessing the registers directly, add a map
> to translate offsets to the real registers addresses for each IP.
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
