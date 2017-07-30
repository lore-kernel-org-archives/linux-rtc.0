Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBDO367FQKGQEJEGXGNI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v142si614565wmv.8.2017.07.30.07.30.37
        for <rtc-linux@googlegroups.com>;
        Sun, 30 Jul 2017 07:30:37 -0700 (PDT)
Date: Sun, 30 Jul 2017 16:30:36 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 2/2] RTC: s35390a: implement ioctls
Message-ID: <20170730143036.amozufkop6gc6sif@piout.net>
References: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
 <bc0dd162f9b89349b41087f1fd710409cd9aaa8f.1499240924.git.fabien.lahoudere@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <bc0dd162f9b89349b41087f1fd710409cd9aaa8f.1499240924.git.fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/07/2017 at 10:02:30 +0200, Fabien Lahoudere wrote:
> Implements RTC_VL_READ and RTC_VL_CLR ioctls.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> ---
>  drivers/rtc/rtc-s35390a.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
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
