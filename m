Return-Path: <rtc-linux+bncBDY3NC743AGBBAN7TS3QKGQE7WDERMQ@googlegroups.com>
Received: from smtprelay.hostedemail.com (smtprelay0131.hostedemail.com. [216.40.44.131])
        by gmr-mx.google.com with ESMTPS id p10si1046918igg.1.2016.03.14.13.30.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2016 13:30:56 -0700 (PDT)
Message-ID: <1457987453.11972.133.camel@perches.com>
Subject: [rtc-linux] Re: [PATCH v2] rtc: s3c: Don't print an error on probe deferral
From: Joe Perches <joe@perches.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski
 <k.kozlowski@samsung.com>,  rtc-linux@googlegroups.com
Date: Mon, 14 Mar 2016 13:30:53 -0700
In-Reply-To: <1457987157-1177-1-git-send-email-javier@osg.samsung.com>
References: <1457987157-1177-1-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 2016-03-14 at 17:25 -0300, Javier Martinez Canillas wrote:
> The clock and source clock looked up by the driver may not be available
> just because the clock controller driver was not probed yet so printing
> an error in this case is not correct and only adds confusion to users.
> 
> However, knowing that a driver's probe was deferred may be useful so it
> can be printed as debug information.

Hello again Javier:
> +			dev_dbg(&pdev->dev, "probe deferred due missing rtc clk\n");

Again, intelligible English would not use "due"
but would use "due to" or "because of".

> +				dev_dbg(&pdev->dev,
> +					"probe deferred due missing rtc src clk\n");

here too.

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
