Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBUWIWLCQKGQEOUPIYTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d5si1020047wmc.1.2017.02.21.12.34.26
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 12:34:26 -0800 (PST)
Date: Tue, 21 Feb 2017 21:34:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Phil Reid <preid@electromag.com.au>
Cc: a.zummo@towertech.it, akinobu.mita@gmail.com,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: ds3232: Add regmap max_register definition.
Message-ID: <20170221203426.nfwxtgpwdkxpb5o4@piout.net>
References: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
 <1487295898-90177-3-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1487295898-90177-3-git-send-email-preid@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 17/02/2017 at 09:44:57 +0800, Phil Reid wrote:
> Add the max_register  to the regmap_config definition. This allows
> dumping of the device's registers via the regmap debugfs interface.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/rtc/rtc-ds3232.c | 2 ++
>  1 file changed, 2 insertions(+)
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
