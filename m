Return-Path: <rtc-linux+bncBD2OLRXW4ABBBTH3X22AKGQEZOIDSSY@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id r7si65525pfr.1.2016.01.08.05.46.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 05:46:52 -0800 (PST)
Message-ID: <568FBB6D.2020904@nvidia.com>
Date: Fri, 8 Jan 2016 19:06:45 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<rtc-linux@googlegroups.com>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <linus.walleij@linaro.org>, <gnurou@gmail.com>,
	<lee.jones@linaro.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>
Subject: Re: [rtc-linux] [PATCH 5/6] rtc: max77620: add support for
 max77620/max20024 RTC driver
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com> <1452177524-23192-6-git-send-email-ldewangan@nvidia.com> <CAJKOXPd938soaa5M0GFo5HpVCYzAS1w8j8Hko3Ja9mx47NYkEQ@mail.gmail.com> <568F8D7E.10500@nvidia.com> <20160108125117.GM6588@sirena.org.uk> <568FB3DD.4090503@nvidia.com> <20160108133648.GQ6588@sirena.org.uk>
In-Reply-To: <20160108133648.GQ6588@sirena.org.uk>
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


On Friday 08 January 2016 07:06 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Fri, Jan 08, 2016 at 06:34:29PM +0530, Laxman Dewangan wrote:
>
>> If we get the parent device, regmap handle and interrupt number from mfd
>> core independent of the PMIC (MAX77620 or MAX77686), then same driver can be
>> used here.
>> Two way which I can think of here:
> Parent device is just dev->parent, you can use dev_get_regmap() to get a
> regmap given a struct device and you can use platform resources to pass
> the interrupts to the children from the MFD (there's some examples,
> wm831x is one).
>
>

I think it should work with named regmap. mfd whould init regmap with 
name and rtc driver should ask with same name.

I saw three drivers which looks same:
rtc-max77620.c (new from me) and already available rtc-max77686.c, 
rtc-max77802.c

Seems I can develop IP based rtc driver as rtc-max77xxx.c


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
