Return-Path: <rtc-linux+bncBD2OLRXW4ABBBZ6JXS2QKGQED5OSTRA@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id tn7si3450684pac.1.2016.02.01.01.27.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2016 01:27:03 -0800 (PST)
Message-ID: <56AF2243.50305@nvidia.com>
Date: Mon, 1 Feb 2016 14:45:47 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: kbuild test robot <lkp@intel.com>, <kbuild-all@01.org>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <broonie@kernel.org>,
	<a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
	<lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	<k.kozlowski@samsung.com>, <vreddytalla@nvidia.com>, Mallikarjun Kasoju
	<mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V7 2/8] mfd: max77620: add core driver for MAX77620/MAX20024
References: <201601310157.sKXyINX7%fengguang.wu@intel.com> <56ACEEE1.1050800@nvidia.com> <20160201082553.GW3368@x1> <56AF17D6.2090106@nvidia.com> <20160201090239.GB3368@x1>
In-Reply-To: <20160201090239.GB3368@x1>
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


On Monday 01 February 2016 02:32 PM, Lee Jones wrote:
> On Mon, 01 Feb 2016, Laxman Dewangan wrote:
>
>> On Monday 01 February 2016 01:55 PM, Lee Jones wrote:
>>> On Sat, 30 Jan 2016, Laxman Dewangan wrote:
>>>
>>>> This depends on patch
>>>> [PATCH V2] mfd: core: add macro for adding mfd cells
>>>>
>>>> and due to absence of this patch, it reports the error.
>>> If you have dependencies, why aren't they in this set?
>>>
>> This change is not related to the series as such and so independent.
>> I just thought that mentioning on commit log will be fine here. May
>> be I missed some points here.
> If you have patches which use/depend on it, then it's not so
> independent, right?

Hmm.. true. I had different thought that the core header is independent 
as it does not depends on other but this series dependent which depends 
on core header. Seems something I missed.
Idea was to review md header independently and used on this series.



>> Let me know if I need to add this to back on series.
>   
> In order to avoid any mishaps, that would be preferable, yes.
>
I will respin this series to V8 once I will have change from you per 
discussion on other email.


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
