Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBK4YXG6AKGQEGYQFVCA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b77si939791wmb.1.2016.07.19.08.50.02
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Jul 2016 08:50:02 -0700 (PDT)
Date: Tue, 19 Jul 2016 17:50:02 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	k.kozlowski@samsung.com, javier@osg.samsung.com,
	pankaj.dubey@samsung.com
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: s3c: Remove unnecessary call to
 disable already disabled clock
Message-ID: <20160719155002.GK7132@piout.net>
References: <1467712733-15800-1-git-send-email-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467712733-15800-1-git-send-email-alim.akhtar@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/07/2016 at 15:28:52 +0530, Alim Akhtar wrote :
> At the end of s3c_rtc_probe(), s3c_rtc_disable_clk() being called with rtc
> clock already disabled (by s3c_rtc_gettime()), which looks extra and
> unnecessary call. Lets clean it up.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c |    2 --
>  1 file changed, 2 deletions(-)
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
