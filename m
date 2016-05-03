Return-Path: <rtc-linux+bncBDS7HNEFSALRBN44UK4QKGQEHFZXH7Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t18si628938wmt.0.2016.05.03.04.40.39
        for <rtc-linux@googlegroups.com>;
        Tue, 03 May 2016 04:40:39 -0700 (PDT)
Date: Tue, 3 May 2016 13:40:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: stmp3xxx: print message on error
Message-ID: <20160503114038.GG2335@piout.net>
References: <1462043490-21448-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462043490-21448-1-git-send-email-sudipm.mukherjee@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 30/04/2016 at 20:11:30 +0100, Sudip Mukherjee wrote :
> stmp3xxx_wdt_register() can fail as platform_device_alloc() or
> platform_device_add() can fail. But when it fails it failed silently.
> Lets print out an error message on failure so that user will atlest
> know that there was some error.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
> 
> v1 -  returned error while failing in the probe.
> 
>  drivers/rtc/rtc-stmp3xxx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
Applied, thanks.

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
