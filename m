Return-Path: <rtc-linux+bncBDJIP47K7MERBANPS63AKGQEAW42EII@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id 79si999090pft.0.2016.02.18.06.38.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2016 06:38:57 -0800 (PST)
Date: Thu, 18 Feb 2016 08:38:53 -0600
From: Rob Herring <robh@kernel.org>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: s3c: Document in binding that only
 s3c6410 needs a src clk
Message-ID: <20160218143853.GF9654@rob-hp-laptop>
References: <1455545466-25709-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455545466-25709-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Feb 15, 2016 at 11:11:06AM -0300, Javier Martinez Canillas wrote:
> The S3C binding doc says that the RTC and RTC source clocks are required
> but the S3C driver supports different HW IP and only the s3c6410 needs a
> source clock.
> 
> Fix the binding explaining that the source clock is only needed for the
> s3c6410-rtc compatible controller.
> 
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> ---
> Hello,
> 
> This patch depends on a previous one that was picked by Rob Herring so
> this one has to go through his tree again and not through the RTC tree
> to avoid conflicts.

Ugg, sent pull request today. It should be in Linus' tree now.

This can go thru rtc tree if you prefer. Otherwise, I'll queue it up for 
4.6.

> 

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
