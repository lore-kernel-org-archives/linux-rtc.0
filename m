Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB7X7TXEQKGQEVBFEGQQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id a197si19340wmd.0.2017.05.25.18.08.14
        for <rtc-linux@googlegroups.com>;
        Thu, 25 May 2017 18:08:14 -0700 (PDT)
Date: Fri, 26 May 2017 03:08:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: ds1307: convert driver to regmap
Message-ID: <20170526010813.qjrnsy4vkqjnhv24@piout.net>
References: <36fd14db-4bd7-dce5-b699-8b621af72f2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <36fd14db-4bd7-dce5-b699-8b621af72f2a@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/03/2017 at 18:52:34 +0100, Heiner Kallweit wrote:
> This patch converts the ds1307 driver to using regmap. It's a rather
> big patch and I can test with DS3231 only. With this chip it's
> working fine.
> 
> I'd appreciate if people with other supported hardware could test as
> well.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - rebased on top of latest rtc tree
> ---
>  drivers/rtc/rtc-ds1307.c | 603 +++++++++++++++++------------------------------
>  1 file changed, 221 insertions(+), 382 deletions(-)
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
