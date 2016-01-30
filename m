Return-Path: <rtc-linux+bncBD2OLRXW4ABBBAPDWO2QKGQES2QWMFA@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ui7si2740148pab.0.2016.01.30.09.23.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jan 2016 09:23:13 -0800 (PST)
Message-ID: <56ACEEE1.1050800@nvidia.com>
Date: Sat, 30 Jan 2016 22:42:01 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: kbuild test robot <lkp@intel.com>
CC: <kbuild-all@01.org>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <linus.walleij@linaro.org>, <gnurou@gmail.com>,
	<lee.jones@linaro.org>, <broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	<swarren@nvidia.com>, <treding@nvidia.com>, <k.kozlowski@samsung.com>,
	<vreddytalla@nvidia.com>, Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V7 2/8] mfd: max77620: add core driver for MAX77620/MAX20024
References: <201601310157.sKXyINX7%fengguang.wu@intel.com>
In-Reply-To: <201601310157.sKXyINX7%fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This depends on patch
[PATCH V2] mfd: core: add macro for adding mfd cells

and due to absence of this patch, it reports the error.



On Saturday 30 January 2016 10:46 PM, kbuild test robot wrote:
> Hi Laxman,
>
> [auto build test ERROR on pinctrl/for-next]
> [also build test ERROR on v4.5-rc1 next-20160129]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Laxman-Dewangan/Add-support-for-MAXIM-MAX77620-MAX20024-PMIC/20160131-005355
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git for-next
> config: i386-allmodconfig (attached as .config)
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>>> drivers/mfd/max77620.c:57:2: error: implicit declaration of function 'DEFINE_MFD_CELL_NAME' [-Werror=implicit-function-declaration]
>       DEFINE_MFD_CELL_NAME("max77620-pinctrl"),
>       ^
>>> drivers/mfd/max77620.c:57:2: error: initializer element is not constant
>     drivers/mfd/max77620.c:57:2: note: (near initialization for 'max77620_children[0].name')
>>> drivers/mfd/max77620.c:58:2: error: implicit declaration of function 'DEFINE_MFD_CELL_NAME_RESOURCE' [-Werror=implicit-function-declaration]
>       DEFINE_MFD_CELL_NAME_RESOURCE("max77620-gpio", gpio_resources),
>       ^
>     drivers/mfd/max77620.c:58:2: error: initializer element is not constant
>     drivers/mfd/max77620.c:58:2: note: (near initialization for 'max77620_children[0].id')
>     drivers/mfd/max77620.c:59:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME("max77620-pmic"),
>       ^
>     drivers/mfd/max77620.c:59:2: note: (near initialization for 'max77620_children[0].usage_count')
>     drivers/mfd/max77620.c:60:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME_RESOURCE("max77620-rtc", rtc_resources),
>       ^
>     drivers/mfd/max77620.c:60:2: note: (near initialization for 'max77620_children[0].enable')
>     drivers/mfd/max77620.c:61:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME_RESOURCE("max77620-power", power_resources),
>       ^
>     drivers/mfd/max77620.c:61:2: note: (near initialization for 'max77620_children[0].disable')
>     drivers/mfd/max77620.c:62:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME("max77620-watchdog"),
>       ^
>     drivers/mfd/max77620.c:62:2: note: (near initialization for 'max77620_children[0].suspend')
>     drivers/mfd/max77620.c:63:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME("max77620-clock"),
>       ^
>     drivers/mfd/max77620.c:63:2: note: (near initialization for 'max77620_children[0].resume')
>     drivers/mfd/max77620.c:64:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME_RESOURCE("max77620-thermal", thermal_resources),
>       ^
>     drivers/mfd/max77620.c:64:2: note: (near initialization for 'max77620_children[0].platform_data')
>     drivers/mfd/max77620.c:68:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME("max20024-pinctrl"),
>       ^
>     drivers/mfd/max77620.c:68:2: note: (near initialization for 'max20024_children[0].name')
>     drivers/mfd/max77620.c:69:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME_RESOURCE("max20024-gpio", gpio_resources),
>       ^
>     drivers/mfd/max77620.c:69:2: note: (near initialization for 'max20024_children[0].id')
>     drivers/mfd/max77620.c:70:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME("max20024-pmic"),
>       ^
>     drivers/mfd/max77620.c:70:2: note: (near initialization for 'max20024_children[0].usage_count')
>     drivers/mfd/max77620.c:71:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME_RESOURCE("max20024-rtc", rtc_resources),
>       ^
>     drivers/mfd/max77620.c:71:2: note: (near initialization for 'max20024_children[0].enable')
>     drivers/mfd/max77620.c:72:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME_RESOURCE("max20024-power", power_resources),
>       ^
>     drivers/mfd/max77620.c:72:2: note: (near initialization for 'max20024_children[0].disable')
>     drivers/mfd/max77620.c:73:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME("max20024-watchdog"),
>       ^
>     drivers/mfd/max77620.c:73:2: note: (near initialization for 'max20024_children[0].suspend')
>     drivers/mfd/max77620.c:74:2: error: initializer element is not constant
>       DEFINE_MFD_CELL_NAME("max20024-clock"),
>       ^
>     drivers/mfd/max77620.c:74:2: note: (near initialization for 'max20024_children[0].resume')
>     cc1: some warnings being treated as errors
>
> vim +/DEFINE_MFD_CELL_NAME +57 drivers/mfd/max77620.c
>
>      51		REGMAP_IRQ_REG(MAX77620_IRQ_LBT_MBATLOW, 1, MAX77620_IRQ_LBM_MASK),
>      52		REGMAP_IRQ_REG(MAX77620_IRQ_LBT_TJALRM1, 1, MAX77620_IRQ_TJALRM1_MASK),
>      53		REGMAP_IRQ_REG(MAX77620_IRQ_LBT_TJALRM2, 1, MAX77620_IRQ_TJALRM2_MASK),
>      54	};
>      55	
>      56	static struct mfd_cell max77620_children[] = {
>    > 57		DEFINE_MFD_CELL_NAME("max77620-pinctrl"),
>    > 58		DEFINE_MFD_CELL_NAME_RESOURCE("max77620-gpio", gpio_resources),
>      59		DEFINE_MFD_CELL_NAME("max77620-pmic"),
>      60		DEFINE_MFD_CELL_NAME_RESOURCE("max77620-rtc", rtc_resources),
>      61		DEFINE_MFD_CELL_NAME_RESOURCE("max77620-power", power_resources),
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

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
