Return-Path: <rtc-linux+bncBDS7HNEFSALRBZFX3GXAKGQE36QE4VY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id jv9si30743wid.0.2015.08.20.15.59.48
        for <rtc-linux@googlegroups.com>;
        Thu, 20 Aug 2015 15:59:48 -0700 (PDT)
Date: Fri, 21 Aug 2015 00:59:47 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org,
	a.zummo@towertech.it, cw00.choi@samsung.com,
	k.kozlowski@samsung.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: s3c: fix disabled clocks for alarm
Message-ID: <20150820225947.GB3769@piout.net>
References: <1439374906-27841-1-git-send-email-jy0922.shim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439374906-27841-1-git-send-email-jy0922.shim@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 12/08/2015 at 19:21:46 +0900, Joonyoung Shim wrote :
> The clock enable/disable codes for alarm have been removed from
> commit 24e1455493da ("drivers/rtc/rtc-s3c.c: delete duplicate clock
> control") and the clocks are disabled even if alarm is set, so alarm
> interrupt can't happen.
> 
> The s3c_rtc_setaie function can be called several times with 'enabled'
> argument having same value, so it needs to check whether clocks are
> enabled or not.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: <stable@vger.kernel.org> # v4.1
> ---
> This is v2 of prior patch "[PATCH 4/4] rtc: s3c: enable/disable clocks
> for alarm".
> 
> Changelog for v2:
> - commit messages is modified by Krzysztof suggestion
> - make to backportable patch
> - add Cc-stable
> 
>  drivers/rtc/rtc-s3c.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 

Applied, thanks.

However, ...

> @@ -39,6 +39,7 @@ struct s3c_rtc {
>  	void __iomem *base;
>  	struct clk *rtc_clk;
>  	struct clk *rtc_src_clk;
> +	bool clk_disabled;
>  

This is quite unusual and I would say the principle of least
astonishment would require using clk_enabled and explicitly set it to
true in the probe. I don't expect a lot of changes regarding the clocks
in the probe so this is probably OK but doing so will require extra
carefulness.

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
