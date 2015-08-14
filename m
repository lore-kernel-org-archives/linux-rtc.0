Return-Path: <rtc-linux+bncBD2536XZRAKBBY4RW6XAKGQE2EFUYBY@googlegroups.com>
Received: from mail-la0-x235.google.com (mail-la0-x235.google.com. [2a00:1450:4010:c03::235])
        by gmr-mx.google.com with ESMTPS id ku1si181070lbc.3.2015.08.14.03.54.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2015 03:54:26 -0700 (PDT)
Received: by mail-la0-x235.google.com with SMTP id i9so41440597lah.2
        for <rtc-linux@googlegroups.com>; Fri, 14 Aug 2015 03:54:26 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
Date: Fri, 14 Aug 2015 12:54:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, rtc-linux@googlegroups.com,
	tony@atomide.com, alexandre.belloni@free-electrons.com,
	akpm@linux-foundation.org, johan@kernel.org,
	grygorii.strashko@ti.com, bcousson@baylibre.com,
	devicetree@vger.kernel.org, t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: omap: Add external clock enabling support
Message-ID: <20150814105423.GA20570@localhost>
References: <1439449668-32301-1-git-send-email-j-keerthy@ti.com>
 <1439449668-32301-3-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439449668-32301-3-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Aug 13, 2015 at 12:37:48PM +0530, Keerthy wrote:
> Configure the clock source to either internal clock
> or external clock based on the availability of the clocks.
> External clock is preferred as it can be ticking during suspend.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

> @@ -627,6 +642,17 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (reg != new_ctrl)
>  		rtc_write(rtc, OMAP_RTC_CTRL_REG, new_ctrl);
>  
> +	/*
> +	 * If we have the external clock then
> +	 * Switch to external clock so we can keep ticking
> +	 * acorss suspend
> +	 */

You should fix up the comment (e.g. stray capitalisation and typo) as
well.

Perhaps reword as

	/*
	 * If we have an external clock then switch to it so we can keep
	 * ticking across suspend.
	 */

Johan

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
