Return-Path: <rtc-linux+bncBAABBIO2Y64QKGQEALGTYSY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from root.phytec.de (mail.x-arc.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id k143si85895wmg.1.2016.05.10.07.16.01
        for <rtc-linux@googlegroups.com>;
        Tue, 10 May 2016 07:16:01 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v5 3/6] regulator: rk808: Add regulator driver
 for RK818
To: Lee Jones <lee.jones@linaro.org>
References: <1462886340-7893-1-git-send-email-w.egorov@phytec.de>
 <1462886340-7893-4-git-send-email-w.egorov@phytec.de>
 <20160510140320.GO19473@dell>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
From: Wadim Egorov <w.egorov@phytec.de>
Message-ID: <5731ECFB.2000207@phytec.de>
Date: Tue, 10 May 2016 16:15:23 +0200
MIME-Version: 1.0
In-Reply-To: <20160510140320.GO19473@dell>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 10.05.2016 16:03, Lee Jones wrote:
> On Tue, 10 May 2016, Wadim Egorov wrote:
>
>> Add support for the rk818 regulator. The regulator module consists
>> of 4 DCDCs, 9 LDOs, 1 switch and 1 BOOST converter which is used to
>> power OTG and HDMI5V.
>>
>> The output voltages are configurable and are meant to supply power
>> to the main processor and other components.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>  drivers/regulator/Kconfig           |   4 +-
>>  drivers/regulator/rk808-regulator.c | 143 ++++++++++++++++++++++++++++++++++--
>>  2 files changed, 138 insertions(+), 9 deletions(-)
> Needs an Ack before I can take the set.
>

Mark acked this patch in v3.
After small changes I removed the ack again. I don't know if it is ok to
keep an Acked-by with small changes in the patch.

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
