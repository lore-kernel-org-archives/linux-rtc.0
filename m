Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB76267FQKGQESPZF4VA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id m191si4186845wmg.9.2017.07.30.07.30.23
        for <rtc-linux@googlegroups.com>;
        Sun, 30 Jul 2017 07:30:23 -0700 (PDT)
Date: Sun, 30 Jul 2017 16:30:22 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/2] RTC: s35390a: handle invalid RTC time
Message-ID: <20170730143022.alvin2p7d5scatkj@piout.net>
References: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
 <0ee84ea918faab368ed36b73dfc7fdff07c4b4b8.1499240924.git.fabien.lahoudere@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <0ee84ea918faab368ed36b73dfc7fdff07c4b4b8.1499240924.git.fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/07/2017 at 10:02:29 +0200, Fabien Lahoudere wrote:
> If RTC time have been altered by low voltage, we notify users
> that RTC time is invalid by returning -EINVAL.
> The RTC time needs to be set correctly to clear the invalid flag.
> If the RTC is not set before restarting, the information will be lost.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> ---
>  drivers/rtc/rtc-s35390a.c | 72 +++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 30 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
