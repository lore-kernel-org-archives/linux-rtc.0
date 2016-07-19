Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBNUYXG6AKGQENPF6VTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r197si833520wmf.2.2016.07.19.08.50.14
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Jul 2016 08:50:14 -0700 (PDT)
Date: Tue, 19 Jul 2016 17:50:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	k.kozlowski@samsung.com, javier@osg.samsung.com,
	pankaj.dubey@samsung.com, stable@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: s3c: Add s3c_rtc_{enable/disable}_clk
 in s3c_rtc_setfreq()
Message-ID: <20160719155013.GL7132@piout.net>
References: <1467712733-15800-1-git-send-email-alim.akhtar@samsung.com>
 <1467712733-15800-2-git-send-email-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467712733-15800-2-git-send-email-alim.akhtar@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/07/2016 at 15:28:53 +0530, Alim Akhtar wrote :
> As per code flow s3c_rtc_setfreq() will get called with rtc clock disabled
> and in set_freq we perform h/w registers read/write, which results in a
> kernel crash on exynos7 platform while probing rtc driver.
> Below is code flow:
> s3c_rtc_probe()
>     clk_prepare_enable(info->rtc_clk) // rtc clock enabled
>     s3c_rtc_gettime() // will enable clk if not done, and disable it upon exit
>     s3c_rtc_setfreq() //then this will be called with clk disabled
> 
> This patch take cares of such issue by adding s3c_rtc_{enable/disable}_clk in
> s3c_rtc_setfreq().
> 
> Fixes: 24e1455493da ("drivers/rtc/rtc-s3c.c: delete duplicate clock control")
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c |    2 ++
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
