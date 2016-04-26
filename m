Return-Path: <rtc-linux+bncBDHPTCWTXEHRBP6I7S4AKGQEAGSPGHQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from gloria.sntech.de (gloria.sntech.de. [95.129.55.99])
        by gmr-mx.google.com with ESMTPS id u137si463013wmd.1.2016.04.26.01.18.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 01:18:06 -0700 (PDT)
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] Re: [PATCH v3 4/8] regulator: rk808: Migrate to regulator
 core's simplified DT parsing code
Date: Tue, 26 Apr 2016 10:17:59 +0200
Message-ID: <2669414.IKg01zC8vG@diego>
In-Reply-To: <571F1CB4.10200@phytec.de>
References: <1461590448-47685-1-git-send-email-w.egorov@phytec.de> <20160425173911.GQ3217@sirena.org.uk> <571F1CB4.10200@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Am Dienstag, 26. April 2016, 09:45:56 schrieb Wadim Egorov:
> On 25.04.2016 19:39, Mark Brown wrote:
> > On Mon, Apr 25, 2016 at 03:20:44PM +0200, Wadim Egorov wrote:
> >> A common simplified DT parsing code for regulators was introduced in
> >> commit a0c7b164ad11 ("regulator: of: Provide simplified DT parsing
> >> method")
> > 
> > This doesn't apply against current code, please check and resend.
> 
> Hm, for me all patches apply to the current code.
> This patch depends on the first rename patch. Maybe this is the problem?

which is the reason why renaming stuff makes everything just more complicated 
without providing additional value ;-) 

The first patch would go through the mfd-tree (if accepted by Lee and Acked by 
the other involved subsystem maintainers) which would then need a stable 
branch merged into the regulator tree - or after the first patch goes in you 
simply wait for a kernel release.

Normally I would expect the reasonable kernel developer to be able to simply 
read code, kconfig, docs stating the drivers being for rk808 and rk818 without 
getting "confused" by some structs mentioning the rk808.


Heiko

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
