Return-Path: <rtc-linux+bncBAABBV5Z7S4AKGQESIKKG3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from root.phytec.de (mail.phycard.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id k143si51279wmg.1.2016.04.26.00.46.31
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Apr 2016 00:46:31 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 4/8] regulator: rk808: Migrate to regulator
 core's simplified DT parsing code
To: Mark Brown <broonie@kernel.org>
References: <1461590448-47685-1-git-send-email-w.egorov@phytec.de>
 <1461590448-47685-5-git-send-email-w.egorov@phytec.de>
 <20160425173911.GQ3217@sirena.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
From: Wadim Egorov <w.egorov@phytec.de>
Message-ID: <571F1CB4.10200@phytec.de>
Date: Tue, 26 Apr 2016 09:45:56 +0200
MIME-Version: 1.0
In-Reply-To: <20160425173911.GQ3217@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 25.04.2016 19:39, Mark Brown wrote:
> On Mon, Apr 25, 2016 at 03:20:44PM +0200, Wadim Egorov wrote:
>> A common simplified DT parsing code for regulators was introduced in
>> commit a0c7b164ad11 ("regulator: of: Provide simplified DT parsing
>> method")
> This doesn't apply against current code, please check and resend.

Hm, for me all patches apply to the current code.
This patch depends on the first rename patch. Maybe this is the problem?

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
