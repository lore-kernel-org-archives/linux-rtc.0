Return-Path: <rtc-linux+bncBDJ4N37Q6EERBAUWXK2AKGQEN33ZUOQ@googlegroups.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTP id ui7si5905123pab.0.2016.01.07.07.57.54
        for <rtc-linux@googlegroups.com>;
        Thu, 07 Jan 2016 07:57:54 -0800 (PST)
Date: Thu, 7 Jan 2016 23:56:19 +0800
From: kbuild test robot <lkp@intel.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: kbuild-all@01.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, rtc-linux@googlegroups.com,
	swarren@nvidia.com, treding@nvidia.com,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <201601072308.7XP0yi7D%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1452177524-23192-3-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Laxman,

[auto build test WARNING on pinctrl/for-next]
[also build test WARNING on v4.4-rc8 next-20160107]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Laxman-Dewangan/Add-support-for-MAXIM-MAX77620-MAX20024-PMIC/20160107-225450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mfd/max77620.c:900:3-8: No need to set .owner here. The core will do it.

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
