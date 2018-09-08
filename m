Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:34626 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbeIHTXs (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 8 Sep 2018 15:23:48 -0400
Date: Sat, 8 Sep 2018 16:37:35 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: cmos: Do not export alarm rtc_ops when we do not
 support alarms
Message-ID: <20180908143735.GC2598@piout.net>
References: <20180904145129.17098-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180904145129.17098-1-hdegoede@redhat.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 04/09/2018 16:51:29+0200, Hans de Goede wrote:
> When there is no IRQ configured for the RTC, the rtc-cmos code does not
> support alarms, all alarm rtc_ops fail with -EIO / -EINVAL.
> 
> The rtc-core expects a rtc driver which does not support rtc alarms to
> not have alarm ops at all. Otherwise the wakealarm sysfs attr will read
> as empty rather then returning an error, making it impossible for
> userspace to find out beforehand if alarms are supported.
> 
> A system without an IRQ for the RTC before this patch:
> [root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
> [root@localhost ~]#
> 
> After this patch:
> [root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
> cat: /sys/class/rtc/rtc0/wakealarm: No such file or directory
> [root@localhost ~]#
> 
> This fixes gnome-session + systemd trying to use suspend-then-hibernate,
> which causes systemd to abort the suspend when writing the RTC alarm fails.
> 
> BugLink: https://github.com/systemd/systemd/issues/9988
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/rtc/rtc-cmos.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
Applied, thanks.

However, you must be using an ancient kernel as my email address changed
a while ago ;)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
