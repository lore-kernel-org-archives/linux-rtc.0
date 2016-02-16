Return-Path: <rtc-linux+bncBDS7HNEFSALRBZPNRG3AKGQE7KQISAY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w197si701588wmw.3.2016.02.15.17.09.56
        for <rtc-linux@googlegroups.com>;
        Mon, 15 Feb 2016 17:09:56 -0800 (PST)
Date: Tue, 16 Feb 2016 02:09:56 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: lee.jones@linaro.org, k.kozlowski@samsung.com, javier@osg.samsung.com,
	broonie@kernel.org, gregkh@linuxfoundation.org,
	a.zummo@towertech.it, cw00.choi@samsung.com,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH V7 0/5] rtc: max77686: make max77686 rtc
 driver as IP driver
Message-ID: <20160216010956.GB3310@piout.net>
References: <1455038794-9921-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455038794-9921-1-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 09/02/2016 at 22:56:29 +0530, Laxman Dewangan wrote :
> Based on discussion on patch series of MAX77620 when adding separate
> driver for max77620 RTC, it is discussed to reuse the max77686 driver
> for all CHips MAX77802, MAX77686 and MAX77620. For this, the rtc-max77686
> need to make as IP driver independent of their MFD parent driver.
> 
> This series makes the rtc-max77686 as independent driver from its 
> parent. Required information is passed through the device parent
> which is generic and does not depends on any max77686 specific
> header ifnromation.
> 
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Changes from V1: 
> - Added reviewed/tested by tag which we got from V1.
> - Remove changes from Kconfig.
> - Maintain all register definition in max77686 private header and remove
>   the movement to rtc driver.
> - Taken care of all comments on V1 from Krzysztof and Javier.
> 
> Changes from V2: 
> - Fix the issue of crash in unbind.
> 
> Changes from V3: 
> - Fix suspend-resume after unbind/bind by unmapping virq in remove callback.
> 
> Changes from V5: 
> - Abandon the addition of new API in regmap-irq and add dispose of virq
>   in regmap_del_irq_chip().
> 
> Changes from V6: 
> - make regmap change as independent of this series and rebase it on linux-next
>   20160209
> 
> Laxman Dewangan (5):
>   rtc: max77686: fix checkpatch error
>   rtc: max77686: use rtc regmap to access RTC registers
>   rtc: max77686: avoid reference of parent device info multiple places
>   mfd: max77686: do not set i2c client data for rtc i2c client
>   rtc: max77686: move initialisation of rtc regmap, irq chip locally
> 

All applied, thanks.

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
