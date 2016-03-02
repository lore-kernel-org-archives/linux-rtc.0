Return-Path: <rtc-linux+bncBDS7HNEFSALRBRHQ3W3AKGQEB3KJU2Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w128si226540wmd.0.2016.03.02.15.33.24
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Mar 2016 15:33:24 -0800 (PST)
Date: Thu, 3 Mar 2016 00:33:23 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: k.kozlowski@samsung.com, a.zummo@towertech.it, cw00.choi@samsung.com,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	javier@osg.samsung.com, rklein@nvidia.com
Subject: [rtc-linux] Re: [PATCH V2 1/2] rtc: max77686: Add support for
 MAX20024/MAX77620 RTC IP
Message-ID: <20160302233323.GB2567@piout.net>
References: <1456907785-11942-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456907785-11942-1-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/03/2016 at 14:06:24 +0530, Laxman Dewangan wrote :
> Maxim Semiconductor's PMIC MAX77686 has RTC IP which is
> reused in the MAX77620/MAX20024 PMICs.
> 
> Add support for these devices in MAX77686 RTC driver. This
> device does not have RTC alarm pending status outside of
> RTC IP. The RTC IP is having separate I2C address for its
> register access.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> - Remove macro and use value directly.
> - Handle error returned from platform_get_irq()
> - Remove compatible for max77620.
> - Cleanup like  indenting.
> 
>  drivers/rtc/Kconfig        |  4 ++--
>  drivers/rtc/rtc-max77686.c | 47 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 5 deletions(-)
> 
Both applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
