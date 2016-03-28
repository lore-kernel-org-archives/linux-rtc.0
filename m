Date: Tue, 29 Mar 2016 00:19:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH v2] rtc: s3c: Document in binding that only
 s3c6410 needs a src clk
Message-ID: <20160328221915.GC2346@piout.net>
References: <1455545466-25709-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455545466-25709-1-git-send-email-javier@osg.samsung.com>
List-ID: <rtc-linux.googlegroups.com>

On 15/02/2016 at 11:11:06 -0300, Javier Martinez Canillas wrote :
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
> 

Well, I'm queuing that one in rtc-fixes for 4.6


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
