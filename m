Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBK4NRS7QKGQEYKMHXYY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a126si2332528wmd.1.2016.09.21.15.16.11
        for <rtc-linux@googlegroups.com>;
        Wed, 21 Sep 2016 15:16:11 -0700 (PDT)
Date: Thu, 22 Sep 2016 00:16:10 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Axel Lin <axel.lin@ingics.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: ac100: Add NULL checking for
 devm_kzalloc call
Message-ID: <20160921221610.nufg3iq34bjtwqo6@piout.net>
References: <1473415434-18956-1-git-send-email-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1473415434-18956-1-git-send-email-axel.lin@ingics.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 09/09/2016 at 18:03:54 +0800, Axel Lin wrote :
> devm_kzalloc can return NULL, add NULL checking to prevent NULL pointer
> dereference.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/rtc/rtc-ac100.c | 3 +++
>  1 file changed, 3 insertions(+)
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
