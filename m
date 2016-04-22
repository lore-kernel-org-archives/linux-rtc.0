Return-Path: <rtc-linux+bncBDJIP47K7MERBVER5K4AKGQENAPRNJY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id 17si294034pfw.0.2016.04.22.13.25.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 13:25:56 -0700 (PDT)
Date: Fri, 22 Apr 2016 15:25:50 -0500
From: Rob Herring <robh@kernel.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org,
	lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] Re: [PATCH v2 5/7] mfd: dt-bindings: Add RK818 device
 tree bindings document
Message-ID: <20160422202550.GA10437@rob-hp-laptop>
References: <1461244361-45686-1-git-send-email-w.egorov@phytec.de>
 <1461244361-45686-6-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461244361-45686-6-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Apr 21, 2016 at 03:12:39PM +0200, Wadim Egorov wrote:
> Add device tree bindings documentation for Rockchip's RK818 PMIC.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  Documentation/devicetree/bindings/mfd/rk808.txt | 37 +++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

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
