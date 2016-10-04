Return-Path: <rtc-linux+bncBDKZNNNLXAHBBVPNZW7QKGQE7W77HUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com. [209.85.215.67])
        by gmr-mx.google.com with ESMTPS id c74si180914wmd.3.2016.10.04.02.31.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 02:31:01 -0700 (PDT)
Received: by mail-lf0-f67.google.com with SMTP id s64so10010477lfs.2
        for <rtc-linux@googlegroups.com>; Tue, 04 Oct 2016 02:31:01 -0700 (PDT)
Date: Tue, 4 Oct 2016 11:30:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/4] regulator: Enable compile testing for
 Maxim and Samsung PMIC drivers
Message-ID: <20161004093056.GA8832@kozik-book>
References: <1475441897-15730-1-git-send-email-krzk@kernel.org>
 <1475441897-15730-3-git-send-email-krzk@kernel.org>
 <20161004024055.4kdjvoiig4fwxi54@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161004024055.4kdjvoiig4fwxi54@sirena.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Oct 04, 2016 at 04:40:55AM +0200, Mark Brown wrote:
> On Sun, Oct 02, 2016 at 10:58:15PM +0200, Krzysztof Kozlowski wrote:
> > Most of Maxim and Samsung PMIC/MUIC regulator drivers can be compile
> > tested to increase build coverage.
> 
> All these drivers already just depend on the MFDs which don't have any
> weird architecture dependencies - the main goal with COMPILE_TEST is
> usually to eliminate dependencies which just can't be selected so they
> can be built at all.  Given that there's no easy way to select
> everything in a subsystem otherwise does this buy us a lot?

Initially I thought similar - if parent MFD driver can be
compile-tested, then these children do not need that flag...

However the MFD drivers depend on I2C which (currently) cannot be
removed for compile testing. On the other hand, regulator drivers do not
need that dependency so you can compile-test them with I2C=n. That is
the main benefit. If you wish, I can add this information to the commit
msg.

Best regards,
Krzysztof

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
