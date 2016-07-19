Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBV4PXG6AKGQEA3PUQKA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v14si1040667wmf.0.2016.07.19.08.31.35
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Jul 2016 08:31:35 -0700 (PDT)
Date: Tue, 19 Jul 2016 17:31:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: abx80x: use devm_add_action_or_reset()
Message-ID: <20160719153134.GJ7132@piout.net>
References: <1467577942-31473-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467577942-31473-1-git-send-email-sudipm.mukherjee@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/07/2016 at 21:32:22 +0100, Sudip Mukherjee wrote :
> If devm_add_action() fails we are explicitly calling the cleanup to free
> the resources allocated.  Lets use the helper devm_add_action_or_reset()
> and return directly in case of error, as we know that the cleanup function
> has been already called by the helper if there was any error.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/rtc/rtc-abx80x.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
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
