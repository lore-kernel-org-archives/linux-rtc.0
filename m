Return-Path: <rtc-linux+bncBAABB5HJYW7QKGQESQVXBQI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id um12si6681844pab.2.2016.10.02.13.58.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2016 13:58:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [rtc-linux] [PATCH 0/4] clk/mfd/regulator/rtc: Enable compile testing
 for some Maxim/Samsung drivers
Date: Sun,  2 Oct 2016 22:58:13 +0200
Message-Id: <1475441897-15730-1-git-send-email-krzk@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Some of the Maxim and Samsung PMIC/MUIC drivers can be safely
compile tested to increase build-test coverage.

Rebased on next-20160930.
Patches do not depend on each-other, please pick up as you wish.

I compile-tested it on ~10 architectures, but not on all of possibilities.
Please wait few days before applying so the 0-day robots could parse
it and find possible non-compilable issues.

Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  clk: Enable compile testing for s2mps11 and max77686
  regulator: Enable compile testing for Maxim and Samsung PMIC drivers
  rtc: Enable compile testing for Maxim and Samsung drivers
  mfd: Enable compile testing for max77620 and max77686

 drivers/clk/Kconfig       |  4 ++--
 drivers/mfd/Kconfig       |  4 ++--
 drivers/regulator/Kconfig | 14 +++++++-------
 drivers/rtc/Kconfig       |  7 ++++---
 4 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
