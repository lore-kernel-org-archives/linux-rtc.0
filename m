Return-Path: <rtc-linux+bncBAABBNGG72UQKGQEDAIH7FA@googlegroups.com>
Received: from mail.kapsi.fi (mx1.kapsi.fi. [2001:1bc8:1004::1:25])
        by gmr-mx.google.com with ESMTPS id bm9si1709539lbb.0.2015.04.28.08.11.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Apr 2015 08:11:47 -0700 (PDT)
Message-ID: <553FA320.4040006@kapsi.fi>
Date: Tue, 28 Apr 2015 18:11:28 +0300
From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
MIME-Version: 1.0
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
 Mike Turquette <mturquette@linaro.org>
CC: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>,
 ascha Hauer <kernel@pengutronix.de>,
 David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>,
 Bryan Huntsman <bryanh@codeaurora.org>,
 Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>,
 =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Alexandre Courbot <gnurou@gmail.com>, Tero Kristo <t-kristo@ti.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Michal Simek <michal.simek@xilinx.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-mips@linux-mips.org,
 patches@opensource.wolfsonmicro.com, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] clk: change clk_ops' ->round_rate() prototype
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com> <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The series

Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>

on Jetson-TK1.

I rebased my cpufreq series on top of this and everything's working well 
now. :)

Thanks,
Mikko.

On 04/17/2015 10:29 AM, Boris Brezillon wrote:
> ...

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
