Return-Path: <rtc-linux+bncBDHPTCWTXEHRBIXKQS4QKGQED26FU2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from gloria.sntech.de (gloria.sntech.de. [95.129.55.99])
        by gmr-mx.google.com with ESMTPS id c7si285454wmf.2.2016.04.27.14.54.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 14:54:42 -0700 (PDT)
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: Wadim Egorov <w.egorov@phytec.de>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, a.zummo@towertech.it, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, dianders@chromium.org, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, broonie@kernel.org, galak@codeaurora.org, zyw@rock-chips.com
Subject: [rtc-linux] Re: [PATCH v4 1/7] regulator: rk808: Add
 rk808_reg_ops_ranges for LDO3
Date: Wed, 27 Apr 2016 23:54:36 +0200
Message-ID: <1574567.Qm9YHLQrGG@diego>
In-Reply-To: <1461682450-22173-2-git-send-email-w.egorov@phytec.de>
References: <1461682450-22173-1-git-send-email-w.egorov@phytec.de> <1461682450-22173-2-git-send-email-w.egorov@phytec.de>
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

Am Dienstag, 26. April 2016, 16:54:04 schrieb Wadim Egorov:
> LDO_REG3 descriptor is using linear_ranges.
> Add and use proper ops for LDO_REG3.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

I'm to late to the party judging by Mark's "Aplied" message, but just to 
confirm, this patch sucessfully fixes the issue on veyron-devices reported 
yesterday.


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
