Return-Path: <rtc-linux+bncBD2OLRXW4ABBBN76Q62QKGQEDFG74XI@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id jg4si597795pac.2.2016.01.22.02.06.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 02:06:47 -0800 (PST)
Message-ID: <56A1FCB0.8050306@nvidia.com>
Date: Fri, 22 Jan 2016 15:26:00 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	<linux-kernel@vger.kernel.org>
CC: Kukjin Kim <kgene@kernel.org>, <rtc-linux@googlegroups.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, <linux-samsung-soc@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2 07/10] rtc: max77686: Use dev_warn()
 instead of pr_warn()
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com> <1453407813-14646-8-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453407813-14646-8-git-send-email-javier@osg.samsung.com>
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
> It is better to use dev_*() log functions instead of pr_*() to print
> information about the device in the kernel log in a standardized way.
>
> This also allows to remove the local pr_fmt() defined macro.
>
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
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
