Return-Path: <rtc-linux+bncBCF252X47MMRBTPVVG2AKGQE2FFOWJQ@googlegroups.com>
Received: from zabrina.hetzner-de.towertech.it (zabrina.hetzner-de.towertech.it. [178.63.16.19])
        by gmr-mx.google.com with ESMTP id s132si1154297wmd.1.2016.01.04.05.59.40
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Jan 2016 05:59:40 -0800 (PST)
Date: Mon, 4 Jan 2016 14:59:38 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: zhangqing <zhangqing@rock-chips.com>, heiko@sntech.de,
 lee.jones@linaro.org, huangtao@rock-chips.com, zyw@rock-chips.com,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RESEND PATCH] rtc: rk808: rename rtc-rk808.c to rtc-rk8xx.c
Message-ID: <20160104145938.6c053b5a@linux.lan.towertech.it>
In-Reply-To: <20160104094546.GB32724@piout.net>
References: <1451571295-4193-1-git-send-email-zhangqing@rock-chips.com>
	<20160104094546.GB32724@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 4 Jan 2016 10:45:46 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> I'm not sure it is useful to do that renaming. It is usual to have one
> driver that supports multiple chips named with the forst chip it
> supported.
> 
> Also, what would happen if for example rk855 is not compatible at all
> with the previous implementations?

 Alexandre is absolutely right. There's no need to rename a driver,
 it would just piss off people who are used to that name and
 have it in their scripts. Like when your eth0 gets renamed
 to some obscure enXXX <g>.

-- 

 Best regards,

 Alessandro Zummo - CEO,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

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
