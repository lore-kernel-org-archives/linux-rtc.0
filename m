Return-Path: <rtc-linux+bncBDJ4N37Q6EERBA4JYO4AKGQEE53IEFA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTP id r4si4400401pfr.1.2016.04.15.03.37.55
        for <rtc-linux@googlegroups.com>;
        Fri, 15 Apr 2016 03:37:55 -0700 (PDT)
Date: Fri, 15 Apr 2016 18:36:11 +0800
From: kbuild test robot <lkp@intel.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, mturquette@baylibre.com,
	sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, dianders@chromium.org,
	zyw@rock-chips.com, arnd@arndb.de, k.kozlowski@samsung.com,
	javier@osg.samsung.com, kgene@kernel.org, olof@lixom.net,
	geert+renesas@glider.be, sjoerd.simons@collabora.co.uk,
	treding@nvidia.com, public_timo.s@silentcreek.de
Subject: [rtc-linux] Re: [PATCH 3/6] regulator: rk808: Make rk808 generic,
 rename rk808-regulator.c
Message-ID: <201604151850.X92LLQkG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Wadim,

[auto build test WARNING on regulator/for-next]
[also build test WARNING on v4.6-rc3 next-20160414]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Wadim-Egorov/Add-RK818-PMIC-support/20160415-172610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/regulator/rk8xx-regulator.c:617:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

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
