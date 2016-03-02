Return-Path: <rtc-linux+bncBD2OLRXW4ABBBGM23G3AKGQEXORJTVQ@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id ui7si4840218pab.0.2016.03.01.18.16.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 18:16:57 -0800 (PST)
Message-ID: <56D64A25.5050700@nvidia.com>
Date: Wed, 2 Mar 2016 07:34:21 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<alexandre.belloni@free-electrons.com>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <javier@osg.samsung.com>, <rklein@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: max77686: Use REGMAP_IRQ_REG for
 regmap-rtc-irqs initialisation
References: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com> <1456750705-13579-2-git-send-email-ldewangan@nvidia.com> <56D63B28.9030502@samsung.com>
In-Reply-To: <56D63B28.9030502@samsung.com>
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


On Wednesday 02 March 2016 06:30 AM, Krzysztof Kozlowski wrote:
> On 29.02.2016 21:58, Laxman Dewangan wrote:
>> use macro REGMAP_IRQ_REG from regmap.h to initialise the
>> regmap irq table for max77686.
> Why? Any benefits?
>
>
I think it is better coding to use macro for member initializations 
instead of doing it locally and it improves readability.

I got the similar comment from Lee's in my MFD patches to use macro for 
such initialization and I agreed with him.

As I was here on this driver, thought to use macro.

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
