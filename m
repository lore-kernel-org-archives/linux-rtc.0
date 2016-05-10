Return-Path: <rtc-linux+bncBCZPNS6XRIARBS4DZC4QKGQEHCZPAZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org. [70.85.31.133])
        by gmr-mx.google.com with ESMTPS id xg7si1629794igb.1.2016.05.10.08.44.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 08:44:11 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: rename so the tps6586x-rtc module can be
 autoloaded at boot
To: Nicolas Chauvet <kwizart@gmail.com>
References: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
 linux-tegra@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <573201AD.7080705@wwwdotorg.org>
Date: Tue, 10 May 2016 09:43:41 -0600
MIME-Version: 1.0
In-Reply-To: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/10/2016 04:26 AM, Nicolas Chauvet wrote:
> This module is loaded by the related mfd driver which has
> the needed MODULE_DEVICE_TABLE(i2c,...).
>
> This patch fix the modalias when the rtc driver is built
> as a module, so the right name is used.
> Everything operates correctly when this module is builtin.

I'm sure this used to work. Do you know when/why it broke? Perhaps a 
Fixes: tag would be useful, and perhaps a Cc: stable?

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
