Return-Path: <rtc-linux+bncBDS7HNEFSALRBG7F3KYQKGQEQACOIOQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t72si411142wme.0.2015.11.01.16.47.23
        for <rtc-linux@googlegroups.com>;
        Sun, 01 Nov 2015 16:47:23 -0800 (PST)
Date: Mon, 2 Nov 2015 01:47:22 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, lee.jones@linaro.org,
	broonie@kernel.org, linux-samsung-soc@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v5 4/4] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
Message-ID: <20151102004722.GI22331@piout.net>
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
 <1446186334-16510-5-git-send-email-alim.akhtar@samsung.com>
 <20151101174048.GD22331@piout.net>
 <5636A44D.4090908@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5636A44D.4090908@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/11/2015 at 08:46:21 +0900, Krzysztof Kozlowski wrote :
> On 02.11.2015 02:40, Alexandre Belloni wrote:
> > On 30/10/2015 at 11:55:34 +0530, Alim Akhtar wrote :
> >> RTC found in s2mps15 is almost same as one found on s2mps13
> >> with few differences in RTC_UPDATE register fields, like:
> >> 1> Bit[4] and Bit[1] are reversed
> >>    - On s2mps13
> >>           WUDR -> bit[4], AUDR -> bit[1]
> >>    - On s2mps15
> >> 	  WUDR -> bit[1], AUDR -> bit[4]
> >> 2> In case of s2mps13, for alarm register, need to set both
> >>    WDUR and ADUR high, whereas for s2mps15 only set AUDR to high.
> >> 3> On s2mps15, WUDR, RUDR and AUDR functions should never be used
> >>    at the same time.
> >>
> >> This patch add required changes to enable s2mps15 rtc timer.
> >>
> >> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> >> ---
> >>  drivers/rtc/rtc-s5m.c           |   37 +++++++++++++++++++++++++++++++++----
> >>  include/linux/mfd/samsung/rtc.h |    2 ++
> >>  2 files changed, 35 insertions(+), 4 deletions(-)
> >>
> > Applied after fixing the small alignment issue, thanks.
> > 
> 
> I think you cannot apply it directly because it depends on headers from
> patch 2/4. It won't build.
> 

Yeah, this depends on the mfd tree. I don't thin Lee applied patch 2/4
yet so I'm taking that one for 4.5.

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
