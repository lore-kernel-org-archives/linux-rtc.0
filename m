Return-Path: <rtc-linux+bncBDHZXHXDRAMBB65Z56VAKGQEUYTKQOY@googlegroups.com>
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id k3si58740igf.1.2015.05.19.18.01.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 18:01:47 -0700 (PDT)
Date: Tue, 19 May 2015 18:01:44 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shawn Guo <shawn.guo@linaro.org>,
	ascha Hauer <kernel@pengutronix.de>,
	David Brown <davidb@codeaurora.org>,
	Daniel Walker <dwalker@fifo99.com>,
	Bryan Huntsman <bryanh@codeaurora.org>,
	Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Max Filippov <jcmvbkbc@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>, Barry Song <baohua@kernel.org>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Emilio L?pez <emilio@elopez.com.ar>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>, Tero Kristo <t-kristo@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Simek <michal.simek@xilinx.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-mips@linux-mips.org,
	patches@opensource.wolfsonmicro.com,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com,
	linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
Message-ID: <20150520010144.GA31054@codeaurora.org>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
 <20150507063953.GC32399@codeaurora.org>
 <20150507093702.0b58753d@bbrezillon>
 <20150515174048.4a31af49@bbrezillon>
 <5557267D.7080209@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5557267D.7080209@kapsi.fi>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 05/16, Mikko Perttunen wrote:
> On 05/15/2015 06:40 PM, Boris Brezillon wrote:
> >Hi Stephen,
> >
> >Adding Mikko in the loop (after all, he was the one complaining about
> >this signed long limitation in the first place, and I forgot to add
> >him in the Cc list :-/).
> 
> I think I got it through linux-tegra anyway, but thanks :)
> 
> >
> >Mikko, are you okay with the approach proposed by Stephen (adding a
> >new method) ?
> 
> Yes, sounds good to me. If a driver uses the existing methods with
> too large frequencies, the issue is pretty discoverable anyway. I
> think "adjust_rate" sounds a bit too much like it sets the clock's
> rate, though; perhaps "adjust_rate_request" or something like that?
> 

Well I'm also OK with changing the determine_rate API one more
time, but we'll have to be careful. Invariably someone will push
a new clock driver through some non-clk tree path and we'll get
build breakage. They shouldn't be doing that, so either we do the
change now and push it to -next and see what breaks, or we do
this after -rc1 comes out and make sure everyone has lots of
warning.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

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
